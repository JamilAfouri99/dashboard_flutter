import 'package:qcarder/utils/configuration/image-constants.dart';
import 'package:qcarder/utils/configuration/theme.dart';
import 'package:qcarder/cubit/users/users_cubit.dart';
import 'package:qcarder/cubit/users/users_state.dart';
import 'package:qcarder/utils/navigation/router_manager.dart';
import 'package:qcarder/screens/user/user_screen.dart';
import 'package:qcarder/widgets/app_bar.dart';
import 'package:qcarder/widgets/app_version.dart';
import 'package:qcarder/widgets/drawer.dart';
import 'package:qcarder/widgets/failed_widget.dart';
import 'package:qcarder/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:qcarder_api/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class UsersScreen extends StatelessWidget {
  final TextEditingController searchText = TextEditingController();

  UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => UsersCubit()..fetch())],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const GlobalAppBar(),
        drawer: const GlobalDrawer(),
        floatingActionButton: floatingActionButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
              ),
              child: BlocBuilder<UsersCubit, UsersState>(
                builder: (context, state) => Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: Icon(
                        Icons.search,
                        size: 28,
                        color: Theme.of(context).colorScheme.shadow.withOpacity(0.6),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchText,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        onChanged: (value) => context.read<UsersCubit>().updateSearch(value),
                        decoration: InputDecoration(
                          hintText: 'Search users',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.shadow.withOpacity(0.6),
                            fontSize: 16,
                          ),
                        ),
                        cursorColor: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.clear,
                        size: 20,
                        color: Theme.of(context).colorScheme.shadow.withOpacity(0.6),
                      ),
                      onPressed: () {
                        if (searchText.text.isNotEmpty) {
                          searchText.clear();
                          context.read<UsersCubit>().updateSearch('');
                        }
                      },
                    ),
                  ],
                ),
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
                      color: Theme.of(context).colorScheme.onSurface,
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
}

Widget _users(BuildContext context) {
  return PagedListView<int, User>.separated(
    pagingController: context.read<UsersCubit>().pagingController,
    separatorBuilder: (context, index) => Divider(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
    ),
    builderDelegate: PagedChildBuilderDelegate<User>(
      noMoreItemsIndicatorBuilder: (context) => _noMoreItems(context),
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
              placeholder: (context, url) => CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: AppColors.onError,
              ),
            )
          : Image.asset(
              ImageConstants.placeholderUser,
              width: 50.0,
              height: 50.0,
            ),
    ),
    title: Text(
      user.profile.displayName ?? '',
      style: Theme.of(context).textTheme.bodyMedium,
    ),
    subtitle: Text(
      user.profile.title ?? '',
      style: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(color: Theme.of(context).colorScheme.shadow.withOpacity(0.7)),
    ),
    trailing: IconButton(
      icon: Icon(
        Icons.remove_red_eye_outlined,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: () {
        Uri uri = Uri.parse('https://qcarder.com/users/${user.id}');
        launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      },
    ),
    onTap: () => RouteManager.navigateWithData(
      context,
      () => UserScreen(userId: user.id),
    ),
  );
}

_noMoreItems(BuildContext context) {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'QCarder © 2024',
            style: TextStyle(color: Theme.of(context).colorScheme.shadow.withOpacity(0.8)),
          ),
          Text(
            ' | ',
            style: TextStyle(color: Theme.of(context).colorScheme.shadow.withOpacity(0.8)),
          ),
          AppVersion(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.8),
          )
        ],
      ),
    ),
  );
}

Widget _usersShimmer(BuildContext context) {
  return Shimmer(
    linearGradient: shimmerGradient(context),
    child: ShimmerLoading(
      isLoading: true,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            10,
            (index) => ListTile(
              leading: const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.light,
              ),
              title: Container(
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: AppColors.light,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  ),
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.light,
                    ),
                  ),
                  Container(
                    height: 10,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  ),
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.light,
                    ),
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

FloatingActionButton floatingActionButton(BuildContext context) => FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () => RouteManager.navigateWithData(
        context,
        () => const UserScreen(),
      ),
      tooltip: 'Add user',
      child: const Icon(
        Icons.add,
        color: AppColors.light,
      ),
    );
