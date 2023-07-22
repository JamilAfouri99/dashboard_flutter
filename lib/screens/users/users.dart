import 'package:qcarder/configuration/image_constants.dart';
import 'package:qcarder/configuration/theme.dart';
import 'package:qcarder/cubit/auth/auth_cubit.dart';
import 'package:qcarder/cubit/auth/auth_state.dart';
import 'package:qcarder/cubit/users/users_cubit.dart';
import 'package:qcarder/cubit/users/users_state.dart';
import 'package:qcarder/navigation/router_manager.dart';
import 'package:qcarder/screens/user/user_screen.dart';
import 'package:qcarder/widgets/failed_widget.dart';
import 'package:qcarder/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:qcarder_api/api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersCubit>(
      create: (_) => UsersCubit()..fetch(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          // centerTitle: true,
          title: Text(
            'Group Users',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.light),
          ),
          actions: [
            usersTopActions(context),
          ],
        ),
        floatingActionButton: _floatingActionButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10),
                    child: Icon(
                      Icons.search,
                      color: AppColors.grey.withOpacity(0.5),
                    ),
                  ),
                  BlocBuilder<UsersCubit, UsersState>(
                    builder: (context, state) => Expanded(
                      child: TextField(
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        onChanged: (value) => context.read<UsersCubit>().updateSearch(value),
                        decoration: InputDecoration(
                          hintText: 'Search users',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: AppColors.grey.withOpacity(0.5)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // List of contacts
            // TextButton(
            //   onPressed: () => RouteManager.routerManager(
            //     routeName: RouteConstants.nfc,
            //     context: context,
            //   ),
            //   child: Text('To NFC'),
            // ),
            Expanded(
              child: BlocBuilder<UsersCubit, UsersState>(
                builder: (context, state) {
                  if (state is UsersFailed) {
                    return FailedWidget(
                      error: state.reason.toString(),
                      onPressed: () => context.read<UsersCubit>().fetch(),
                    );
                  } else if (state is UsersLoaded) {
                    return RefreshIndicator(
                      onRefresh: () => Future.sync(
                        () => context.read<UsersCubit>().pagingController.refresh(),
                      ),
                      child: _users(context),
                    );
                  }
                  return _usersShimmer(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget usersTopActions(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) => {},
        builder: (context, state) {
          if (state is AuthenticatedState) {
            return PopupMenuButton<String>(
              onSelected: (result) {
                switch (result) {
                  case 'logout':
                    context.read<AuthCubit>().remoteLogout(context);
                    break;
                  default:
                }
              },
              itemBuilder: (context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Signed in as',
                        style: TextStyle(
                          color: AppColors.grey.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        state.authUser.email,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.grey.withOpacity(0.8),
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        size: 20,
                        color: AppColors.grey.withOpacity(0.8),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Sign out',
                        style: TextStyle(
                          color: AppColors.grey.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 40,
                height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: state.authUser.avatar != null
                    ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        cacheKey: state.authUser.avatar ?? '',
                        imageUrl: state.authUser.avatar ?? '',
                      )
                    : const Icon(
                        Icons.person,
                        color: AppColors.light,
                        size: 25,
                      ),
              ),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}

Widget _users(BuildContext context) {
  return PagedListView<int, User>.separated(
    pagingController: context.read<UsersCubit>().pagingController,
    separatorBuilder: (context, index) => Divider(
      color: AppColors.primary.withOpacity(0.3),
    ),
    builderDelegate: PagedChildBuilderDelegate<User>(
      noMoreItemsIndicatorBuilder: (context) => _noMoreItems(),
      itemBuilder: (context, user, index) => _user(user, context),
      firstPageProgressIndicatorBuilder: (context) => _usersShimmer(context),
    ),
  );
}

Widget _user(User user, BuildContext context) {
  return ListTile(
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: user.avatar != null && user.avatar!.isNotEmpty && user.avatar!.contains('https')
          ? CachedNetworkImage(
              height: 50,
              width: 50,
              cacheKey: user.avatar ?? '',
              imageUrl: user.avatar ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(
                color: AppColors.primary,
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: AppColors.onError,
              ),
            )
          : SvgPicture.asset(
              ImageConstants.user,
              width: 50.0,
              height: 50.0,
            ),
    ),
    title: Text(
      user.profile.displayName ?? '',
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    subtitle: Text(
      user.profile.title ?? '',
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppColors.grey.withOpacity(0.7),
          ),
    ),
    onTap: () => RouteManager.navigateToWithData(
      context,
      () => UserScreen(user: user),
    ),
  );
}

_noMoreItems() {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(20),
      child: Text(
        'QCarder © 2023',
        style: TextStyle(color: AppColors.grey.withOpacity(0.8)),
      ),
    ),
  );
}

Widget _usersShimmer(BuildContext context) {
  return Shimmer(
    linearGradient: shimmerGradient,
    child: ShimmerLoading(
      isLoading: true,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            10,
            (index) => ListTile(
              leading: const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
              ),
              title: Container(
                height: 10,
                color: Colors.grey,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                  ),
                  Container(
                    height: 10,
                    color: Colors.grey,
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.2,
                    color: Colors.grey,
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          ),
        ),
      ),
    ),
  );
}

FloatingActionButton _floatingActionButton(BuildContext context) => FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () => RouteManager.navigateToWithData(
        context,
        () => const UserScreen(),
      ),
      tooltip: 'Add user',
      child: const Icon(Icons.add),
    );
