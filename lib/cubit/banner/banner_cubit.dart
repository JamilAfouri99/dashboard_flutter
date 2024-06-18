import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:qcarder/cubit/banner/banner_state.dart';
import 'package:qcarder/services/global_services.dart';
import 'package:qcarder/services/http/remote_service.dart';
import 'package:qcarder_api/api.dart';

class BannerCubit extends Cubit<BannerState> {
  final ApiClient apiClient = ClientService.apiClient;

  late RemoteService remoteService;
  late GroupsApi groupsApi;

  BannerCubit() : super(BannerUnknown()) {
    groupsApi = GroupsApi(apiClient);
    remoteService = RemoteService();
  }

  Future<void> uploadBanner(String groupId, String profileId, http.MultipartFile banner) async {
    emit(BannerLoading());
    final result = await remoteService.asyncTryCatch(
      () => groupsApi.postGroupFiles(groupId, profileId, banner),
    );
    if (!result.isError) {
      emit(BannerLoaded());
    }
    if (result.isError) {
      emit(BannerFailed(result.error));
    }
  }
}
