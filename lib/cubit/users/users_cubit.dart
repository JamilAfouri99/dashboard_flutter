import 'package:dashboard/cubit/users/users_state.dart';
import 'package:dashboard/helpers/index.dart';
import 'package:dashboard/models/user.dart';
import 'package:dashboard/services/api/users_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UsersCubit extends Cubit<UsersState> {
  final PagingController<int, User> pagingController = PagingController(firstPageKey: 1);
  final UsersApi usersApi;
  final int _pageSize = 10;

  UsersCubit()
      : usersApi = UsersApi(),
        super(UnknownState()) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> fetch({page = 1, perPage = 10}) async {
    emit(LoadingState());
    try {
      final UsersResponse response = await usersApi.fetch(page: page, perPage: perPage);
      List<User> users = response.users ?? [];

      users = _usersSorting(users);
      emit(SuccessState(users, response.pagination));
    } catch (error) {
      emit(FailedState(error.toString()));
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await usersApi.fetch(page: pageKey, perPage: 10);
      List<User> users = response.users ?? [];

      users = _usersSorting(users);

      final isLastPage = users.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(users);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(users, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void searchUsers(String searchText) {
    final sanitizedSearchText = searchText.trim().toLowerCase();
    List<User> filteredUsers = [];
    if (state is SuccessState) {
      if (sanitizedSearchText.isEmpty) {
        filteredUsers = (state as SuccessState).users;
      } else {
        filteredUsers = (state as SuccessState).users.where((user) {
          final fullName = user.firstName != null && user.lastName != null
              ? '${user.firstName} ${user.lastName}'.toLowerCase()
              : '';
          return fullName.contains(sanitizedSearchText);
        }).toList();
      }
      emit(SuccessState(filteredUsers, (state as SuccessState).pagination));
    }
  }

  List<User> _usersSorting(List<User> users) {
    final Map<String, List<User>> groupedContacts = groupByFirstLetter(
      users,
      (contact) => contact.firstName![0].toUpperCase(),
    );
    final Map<String, List<User>> sortedContracts = sortMapByKeys(groupedContacts);

    // Flatten the sorted map values into a single list
    final List<User> sortedUsers = sortedContracts.values.expand((e) => e).toList();

    return sortedUsers;
  }
}
