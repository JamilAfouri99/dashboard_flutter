import 'dart:async';

import 'package:qcarder/cubit/users/users_state.dart';
import 'package:qcarder/helpers/index.dart';
import 'package:qcarder/helpers/search_validation.dart';
import 'package:qcarder/services/http/remote_service.dart';
import 'package:qcarder/services/global_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:qcarder_api/api.dart';

class UsersCubit extends Cubit<UsersState> {
  final PagingController<int, User> pagingController = PagingController(firstPageKey: 1);
  final ApiClient apiClient = ClientService.apiClient;
  late UsersApi usersApi;
  late RemoteService remoteService;

  final int _perPage = 10;
  String _searchUsers = '';
  Timer? _searchDebouncer;

  UsersCubit() : super(UsersUnknown()) {
    remoteService = RemoteService();
    usersApi = UsersApi(apiClient);
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> fetch({page = 1}) async {
    emit(UsersLoading());
    final result = await remoteService.asyncTryCatch(
      () => usersApi.getUsers(page: page, perPage: _perPage),
    );
    if (result.isSuccess && result.value != null) {
      List<User> users = result.value!.data;

      users = _usersSorting(users);
      users = _usersSorting(users);
      emit(UsersLoaded(PaginatedUsers(
        data: users,
        meta: result.value!.meta,
      )));
    }
    if (result.isError) {
      emit(UsersFailed(result.error));
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    final result = await remoteService.asyncTryCatch(
      () => usersApi.getUsers(
        page: pageKey,
        perPage: _perPage,
        search: _searchUsers,
      ),
    );
    if (result.isSuccess && result.value != null) {
      List<User> users = result.value!.data;

      users = _usersSorting(users);

      final isLastPage = users.length < _perPage;
      if (isLastPage) {
        pagingController.appendLastPage(users);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(users, nextPageKey);
      }
    }
    if (result.isError) {
      pagingController.error = result.error;
    }
  }

  void updateSearch(String search) {
    _searchUsers = search;
    if (!isValidSearchData(search)) return;

    // Cancel any previously scheduled refresh
    _searchDebouncer?.cancel();

    // Create a new timer with a delay of 500 milliseconds
    _searchDebouncer = Timer(Duration(milliseconds: 500), () {
      pagingController.refresh();
    });
  }

  List<User> _usersSorting(List<User> users) {
    final Map<String, List<User>> groupedContacts = groupByFirstLetter(
      users,
      (contact) => contact.firstName[0].toUpperCase(),
    );
    final Map<String, List<User>> sortedContracts = sortMapByKeys(groupedContacts);

    // Flatten the sorted map values into a single list
    final List<User> sortedUsers = sortedContracts.values.expand((e) => e).toList();

    return sortedUsers;
  }
}
