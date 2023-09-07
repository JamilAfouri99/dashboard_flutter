import 'package:qcarder/configuration/image_constants.dart';
import 'package:qcarder/configuration/theme.dart';
import 'package:qcarder/cubit/theme/theme_cubit.dart';
import 'package:qcarder/cubit/users/users_cubit.dart';
import 'package:qcarder/cubit/users/users_state.dart';
import 'package:qcarder/navigation/router_manager.dart';
import 'package:qcarder/screens/user/user_screen.dart';
import 'package:qcarder/widgets/app_bar.dart';
import 'package:qcarder/widgets/drawer.dart';
import 'package:qcarder/widgets/failed_widget.dart';
import 'package:qcarder/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:qcarder_api/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UsersCubit()..fetch()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: Scaffold(
        appBar: const GlobalAppBar(),
        drawer: const GlobalDrawer(),
        floatingActionButton: floatingActionButton(context),
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
                      size: 28,
                      color: AppColors.grey.withOpacity(0.6),
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
                          hintStyle:
                              TextStyle(color: AppColors.grey.withOpacity(0.6), fontSize: 16),
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
      style: Theme.of(context).textTheme.bodyMedium,
    ),
    subtitle: Text(
      user.profile.title ?? '',
      style:
          Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.grey.withOpacity(0.7)),
    ),
    trailing: IconButton(
      icon: const Icon(
        Icons.remove_red_eye_outlined,
        color: AppColors.primary,
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

FloatingActionButton floatingActionButton(BuildContext context) => FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () => RouteManager.navigateWithData(
        context,
        () => const UserScreen(),
      ),
      tooltip: 'Add user',
      child: const Icon(Icons.add),
    );
