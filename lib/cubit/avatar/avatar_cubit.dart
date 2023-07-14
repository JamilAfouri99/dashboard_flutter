import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:qcarder/cubit/avatar/avatar_state.dart';
import 'package:qcarder/services/global_services.dart';
import 'package:qcarder/services/http/remote_service.dart';
import 'package:qcarder_api/api.dart';

class AvatarCubit extends Cubit<AvatarState> {
  final ApiClient apiClient = ClientService.apiClient;

  late RemoteService remoteService;
  late UsersApi usersApi;

  AvatarCubit() : super(AvatarUnknown()) {
    usersApi = UsersApi(apiClient);
    remoteService = RemoteService();
  }

  Future<void> uploadAvatar(String userId, http.MultipartFile avatar) async {
    emit(AvatarLoading());
    final result = await remoteService.asyncTryCatch(() => usersApi.postUserFiles(userId, avatar));
    if (!result.isError) {
      emit(AvatarLoaded());
    }
    if (result.isError) {
      emit(AvatarFailed(result.error));
    }
  }
}
