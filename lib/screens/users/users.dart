import 'package:dashboard/configuration/image_constants.dart';
import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/cubit/auth/auth_cubit.dart';
import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:dashboard/cubit/users/users_cubit.dart';
import 'package:dashboard/cubit/users/users_state.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/screens/user/user_screen.dart';
import 'package:dashboard/widgets/failed_widget.dart';
import 'package:dashboard/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:qcarder_api/api.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersCubit>(
      create: (_) => UsersCubit()..fetch(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: Text(
            'Users',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.light),
          ),
          actions: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.logout, color: AppColors.light),
                  tooltip: 'Logout',
                  onPressed: () async {
                    await context.read<AuthCubit>().remoteLogout(context);
                  },
                );
              },
            ),
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
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.search,
                      color: AppColors.grey.withOpacity(0.5),
                    ),
                  ),
                  BlocBuilder<UsersCubit, UsersState>(
                    builder: (context, state) => Expanded(
                      child: TextField(
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
          ? Image.network(
              user.avatar ?? '',
              height: 50,
              width: 50,
              errorBuilder: (context, url, error) => const Icon(Icons.error),
            )
          : SvgPicture.asset(
              ImageConstants.user,
              width: 50.0,
              height: 50.0,
            ),
    ),
    title: Text(
      user.profile.displayName,
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    subtitle: Text(
      user.profile.title ?? '',
      style: Theme.of(context).textTheme.bodySmall,
    ),
    onTap: () => RouteManager.navigateToWithData(
      context,
      () => UserScreen(user: user),
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
      child: const Icon(Icons.add),
      tooltip: 'Add user',
    );
