import 'package:dashboard/cubit/users/users_state.dart';
import 'package:dashboard/models/user.dart';
import 'package:dashboard/services/api/users_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersApi usersApi;
  UsersCubit()
      : usersApi = UsersApi(),
        super(UnknownState());

  List<User> _allUsers = [];
  List<User> _filteredUsers = [];

  Future<void> fetch() async {
    emit(LoadingState());
    try {
      final UsersResponse response = await usersApi.fetch();
      _allUsers = response.users ?? [];
      //TODO: implement pagination

      emit(SuccessState(response.users ?? [], response.pagination));
    } catch (error) {
      emit(FailedState(error.toString()));
    }
  }

  void searchUsers(String searchText) {
    final sanitizedSearchText = searchText.trim().toLowerCase();
    if (sanitizedSearchText.isEmpty) {
      _filteredUsers = _allUsers;
    } else {
      _filteredUsers = _allUsers.where((user) {
        final fullName = user.firstName != null && user.lastName != null
            ? '${user.firstName} ${user.lastName}'.toLowerCase()
            : '';
        return fullName.contains(sanitizedSearchText);
      }).toList();
    }
    emit(SuccessState(_filteredUsers, null));
  }
}
