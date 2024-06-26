//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GroupsApi {
  GroupsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'DELETE /groups/{userId}/profile/{profileId}/files' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] groupId (required):
  ///
  /// * [String] profileId (required):
  ///
  /// * [DeleteGroupProfileFilesDto] deleteGroupProfileFilesDto (required):
  ///   Specify which files are to be deleted by sending the file field with a value of \"true\"
  Future<Response> deleteUserProfileFilesWithHttpInfo(
    String groupId,
    String profileId,
    DeleteGroupProfileFilesDto deleteGroupProfileFilesDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/groups/{userId}/profile/{profileId}/files'
        .replaceAll('{groupId}', groupId)
        .replaceAll('{profileId}', profileId);

    // ignore: prefer_final_locals
    Object? postBody = deleteGroupProfileFilesDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [String] groupId (required):
  ///
  /// * [String] profileId (required):
  ///
  /// * [DeleteGroupProfileFilesDto] deleteGroupProfileFilesDto (required):
  ///   Specify which files are to be deleted by sending the file field with a value of \"true\"
  Future<void> deleteUserProfileFiles(
    String groupId,
    String profileId,
    DeleteGroupProfileFilesDto deleteGroupProfileFilesDto,
  ) async {
    final response = await deleteUserProfileFilesWithHttpInfo(
      groupId,
      profileId,
      deleteGroupProfileFilesDto,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'PATCH /groups/{groupId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] groupId (required):
  ///
  /// * [PatchGroupDto] patchGroupDto (required):
  Future<Response> patchUserGroupWithHttpInfo(
    String groupId,
    PatchGroupDto patchGroupDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/groups/{groupId}'.replaceAll('{groupId}', groupId);

    // ignore: prefer_final_locals
    Object? postBody = patchGroupDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [String] groupId (required):
  ///
  /// * [PatchGroupDto] patchGroupDto (required):
  Future<PatchGroupResponseDto?> patchUserGroup(
    String groupId,
    PatchGroupDto patchGroupDto,
  ) async {
    final response = await patchUserGroupWithHttpInfo(
      groupId,
      patchGroupDto,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'PatchGroupResponseDto',
      ) as PatchGroupResponseDto;
    }
    return null;
  }

  /// Performs an HTTP 'POST /groups/{groupId}/profile/{profileId}/files' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] groupId (required):
  ///
  /// * [String] profileId (required):
  ///
  /// * [MultipartFile] banner (required):
  Future<Response> postGroupFilesWithHttpInfo(
    String groupId,
    String profileId,
    MultipartFile banner,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/groups/{groupId}/profile/{profileId}/files'
        .replaceAll('{groupId}', groupId)
        .replaceAll('{profileId}', profileId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (banner != null) {
      hasFields = true;
      mp.fields[r'banner'] = banner.field;
      mp.files.add(banner);
    }
    if (hasFields) {
      postBody = mp;
    }

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [String] groupId (required):
  ///
  /// * [String] profileId (required):
  ///
  /// * [MultipartFile] banner (required):
  Future<void> postGroupFiles(
    String groupId,
    String profileId,
    MultipartFile banner,
  ) async {
    final response = await postGroupFilesWithHttpInfo(
      groupId,
      profileId,
      banner,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
