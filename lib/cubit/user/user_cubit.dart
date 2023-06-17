import 'package:dashboard/cubit/user/user_state.dart';
import 'package:dashboard/models/user.dart';
import 'package:dashboard/services/api/user_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final UserApi userApi;
  UserCubit()
      : userApi = UserApi(),
        super(UserUnknown());

  bool isEditable = false;

  Future<void> fetch(String userId) async {
    emit(UserLoading());
    try {
      User user = await userApi.fetch(userId);
      emit(UserLoaded(user));
    } catch (error) {
      emit(UserFailed(error.toString()));
    }
  }

  Future<void> updateUser(User updatedUser) async {
    emit(UserLoading());
    try {
      final user = await userApi.update(updatedUser);
      emit(UserLoaded(user));
    } catch (error) {
      emit(UserFailed(error.toString()));
    }
  }

  Future<void> addNewUser(User addedUser) async {
    emit(UserLoading());
    try {
      final user = await userApi.add(addedUser);
      emit(UserLoaded(user));
    } catch (error) {
      emit(UserFailed(error.toString()));
    }
  }

  Future<void> deleteUser(String userId) async {
    emit(UserLoading());
    try {
      await userApi.delete(userId);
      emit(UserLoaded(null));
    } catch (error) {
      emit(UserFailed(error.toString()));
    }
  }

  Future<void> isEditableHandler(bool editable) async {
    emit(UserLoading());
    await Future.delayed(const Duration(milliseconds: 500), () => isEditable = editable);
    emit(UserLoaded(null));
  }
}
