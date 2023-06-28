import 'package:dashboard/cubit/user/user_state.dart';
import 'package:dashboard/services/http/remote_service.dart';
import 'package:dashboard/services/global_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder_api/api.dart';

class UserCubit extends Cubit<UserState> {
  final ApiClient apiClient = ClientService.apiClient;

  late RemoteService remoteService;
  late UsersApi usersApi;

  UserCubit() : super(UserUnknown()) {
    usersApi = UsersApi(apiClient);
    remoteService = RemoteService();
  }

  bool isEditable = false;

  Future<void> getUserById(num userId) async {
    emit(UserLoading());
    final result = await remoteService.asyncTryCatch(() => usersApi.getUserById(userId));
    if (result.isSuccess && result.value != null) {
      emit(UserLoaded(result.value!));
    }
    if (result.isError) {
      emit(UserFailed(result.error));
    }
  }

  Future<void> updateProfile(
    User user,
    PatchUserProfileDto updateUserProfile,
  ) async {
    emit(UserLoading());
    final result = await remoteService.asyncTryCatch(
      () => usersApi.editUserProfile(user.id, user.profile.id, updateUserProfile),
    );
    if (result.isSuccess && result.value != null) {
      user.profile = result.value!;
      emit(UserLoaded(user));
    }
    if (result.isError) {
      emit(UserFailed(result.error));
    }
  }

  Future<void> updateUser(User user, PatchUserDto updateUser) async {
    emit(UserLoading());
    final result = await remoteService.asyncTryCatch(() => usersApi.editUser(user.id, updateUser));
    if (result.isSuccess && result.value != null) {
      //FIXME: return the updaetd user
      emit(UserLoaded(user));
    }
    if (result.isError) {
      emit(UserFailed(result.error));
    }
  }

  Future<void> updateCombined(
    User user,
    PatchUserDto updateUser,
    PatchUserProfileDto updateUserProfile,
  ) async {
    emit(UserLoading());

    final userUpdateResult = await remoteService.asyncTryCatch(
      () => usersApi.editUser(user.id, updateUser),
    );
    final profileUpdateResult = await remoteService.asyncTryCatch(
      () => usersApi.editUserProfile(user.id, user.profile.id, updateUserProfile),
    );

    if (userUpdateResult.isSuccess &&
        userUpdateResult.value != null &&
        profileUpdateResult.isSuccess &&
        profileUpdateResult.value != null) {
      // FIXME: return the updated user
      emit(UserLoaded(user));
    } else if (userUpdateResult.isError) {
      emit(UserFailed(userUpdateResult.error));
    } else if (profileUpdateResult.isError) {
      emit(UserFailed(profileUpdateResult.error));
    }
  }

  Future<void> createUser(PostUserDto newUser) async {
    emit(UserLoading());
    final result = await remoteService.asyncTryCatch(
      () => usersApi.createUser(newUser),
    );
    if (result.isSuccess && result.value != null) {
      emit(UserLoaded(result.value!));
    }
    if (result.isError) {
      emit(UserFailed(result.error));
    }
  }

  Future<void> deleteUser(String userId) async {
    // TODO: implement success status and connect the api
    emit(UserLoading());
    try {
      await Future.delayed(Duration(milliseconds: 500));
      emit(UserLoaded(null));
    } catch (error) {
      emit(UserFailed(error.toString()));
    }
  }

  Future<void> isUpdateForm() async {
    emit(UserLoading());
    await Future.delayed(
      const Duration(milliseconds: 500),
      () => isEditable = true,
    );
    emit(UserLoaded(null));
  }

  Future<void> isNewForm() async {
    isEditable = false;
  }
}
