import 'package:dashboard/configuration/index.dart';
import 'package:dashboard/cubit/auth/auth_cubit.dart';
import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:dashboard/cubit/users/users_cubit.dart';
import 'package:dashboard/cubit/users/users_state.dart';
import 'package:dashboard/models/user.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/screens/user/user_screen.dart';
import 'package:dashboard/widgets/custom_progress_indicator.dart';
import 'package:dashboard/widgets/failed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersCubit>(
      create: (context) => UsersCubit()..fetch(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Contacts', style: Theme.of(context).textTheme.titleLarge),
          actions: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    await context.read<AuthCubit>().logout(context);
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
                        controller: _searchController,
                        onChanged: (value) => context.read<UsersCubit>().searchUsers(value),
                        decoration: InputDecoration(
                          hintText: 'Search contacts',
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
                  return const Center(child: CustomProgressIndicator());
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
    separatorBuilder: (context, index) => const Divider(),
    builderDelegate: PagedChildBuilderDelegate<User>(
      itemBuilder: (context, user, index) => _user(user, context),
    ),
  );
}

Widget _user(User user, BuildContext context) => ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: SvgPicture.asset(
          user.avatar ?? ImageConstants.woman,
          width: 50.0,
          height: 50.0,
        ),
      ),
      title: Text(
        user.firstName ?? '',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        user.role ?? '',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: () => RouteManager.navigateToWithData(
        context,
        () => UserScreen(user: user),
      ),
    );

FloatingActionButton _floatingActionButton(BuildContext context) => FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () => RouteManager.navigateToWithData(
        context,
        () => const UserScreen(),
      ),
      child: const Icon(Icons.add),
    );
