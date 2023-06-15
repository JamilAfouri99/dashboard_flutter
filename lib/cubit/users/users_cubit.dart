import 'package:dashboard/cubit/users/users_state.dart';
import 'package:dashboard/models/user.dart';
import 'package:dashboard/services/api/users_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersApi usersApi;
  UsersCubit()
      : usersApi = UsersApi(),
        super(UnknownState());

  final int _perPage = 10;
  int _currentPage = 1;

  Future<void> fetch() async {
    emit(LoadingState());
    try {
      final UsersResponse response = await usersApi.fetch(page: _currentPage, perPage: _perPage);

      emit(SuccessState(response.users ?? [], response.pagination));
    } catch (error) {
      emit(FailedState(error.toString()));
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
}
