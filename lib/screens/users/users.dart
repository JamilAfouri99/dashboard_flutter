import 'package:dashboard/configuration/index.dart';
import 'package:dashboard/cubit/users/users_cubit.dart';
import 'package:dashboard/cubit/users/users_state.dart';
import 'package:dashboard/helpers/groupe_by_first_letter.dart';
import 'package:dashboard/helpers/sort_map_by_keys.dart';
import 'package:dashboard/models/user.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/screens/user/user_screen.dart';
import 'package:dashboard/widgets/app_bar.dart';
import 'package:dashboard/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersCubit>(
      create: (context) => UsersCubit()..fetch(),
      child: Scaffold(
        appBar: appBar,
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
                  if (state is FailedState) {
                    return RefreshIndicator(
                      onRefresh: () => context.read<UsersCubit>().fetch(),
                      child: Center(
                        child: Text(
                          state.reason.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else if (state is SuccessState) {
                    return RefreshIndicator(
                      onRefresh: () => context.read<UsersCubit>().fetch(),
                      child: _users(state.users, context),
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

Widget _users(List<User> users, BuildContext context) {
  if (users.isEmpty) {
    return Center(
      child: Text(
        'No contacts found',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  final Map<String, List<User>> groupedContacts =
      groupByFirstLetter(users, (contact) => contact.firstName![0].toUpperCase());
  final Map<String, List<User>> sortedContracts = sortMapByKeys(groupedContacts);

  return ListView(
    children: sortedContracts.keys.map((letter) {
      final groupContacts = sortedContracts[letter]!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.05),
              border: Border(
                top: BorderSide(color: AppColors.grey.withOpacity(0.1)),
                bottom: BorderSide(color: AppColors.grey.withOpacity(0.1)),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child: Text(
              letter,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: groupContacts.length,
            itemBuilder: (context, index) {
              return _user(groupContacts[index], context);
            },
          ),
        ],
      );
    }).toList(),
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
      // onTap: () => RouteManager.navigateToWithData(
      //   context,
      //   () => UserScreen(user: user),
      // ),
      onTap: () {},
    );

FloatingActionButton _floatingActionButton(BuildContext context) => FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () => RouteManager.navigateToWithData(
        context,
        () => const UserScreen(),
      ),
      child: const Icon(Icons.add),
    );
