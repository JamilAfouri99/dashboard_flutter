import 'package:qcarder/cubit/user/user_state.dart';
import 'package:qcarder/services/http/remote_service.dart';
import 'package:qcarder/services/global_services.dart';
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

  Future<void> getUserById(String userId) async {
    emit(UserLoading());
    final result =
        await remoteService.asyncTryCatch(() => usersApi.getUserById(userId));
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
      () => usersApi.patchUserProfile(
          user.id, user.profile.id, updateUserProfile),
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
    final result = await remoteService
        .asyncTryCatch(() => usersApi.patchUser(user.id, updateUser));
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
      () => usersApi.patchUser(user.id, updateUser),
    );
    final profileUpdateResult = await remoteService.asyncTryCatch(
      () => usersApi.patchUserProfile(
          user.id, user.profile.id, updateUserProfile),
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
    emit(UserLoading());
    try {
      await remoteService.asyncTryCatch(
        () => usersApi.deleteUser(userId),
      );
      emit(UserLoaded(null));
    } catch (error) {
      emit(UserFailed(error.toString()));
    }
  }

  Future<void> isUpdateForm(String userId) async {
    isEditable = true;
    getUserById(userId);
  }

  Future<void> isNewForm() async {
    isEditable = false;
  }
}
