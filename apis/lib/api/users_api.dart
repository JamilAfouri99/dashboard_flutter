//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UsersApi {
  UsersApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /users' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [PostUserDto] postUserDto (required):
  Future<Response> createUserWithHttpInfo(
    PostUserDto postUserDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users';

    // ignore: prefer_final_locals
    Object? postBody = postUserDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

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
  /// * [PostUserDto] postUserDto (required):
  Future<User?> createUser(
    PostUserDto postUserDto,
  ) async {
    final response = await createUserWithHttpInfo(
      postUserDto,
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
        'User',
      ) as User;
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /users/{userId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userId (required):
  Future<Response> deleteUserWithHttpInfo(
    String userId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}'.replaceAll('{userId}', userId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

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
  /// * [String] userId (required):
  Future<void> deleteUser(
    String userId,
  ) async {
    final response = await deleteUserWithHttpInfo(
      userId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'DELETE /users/{userId}/files' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userId (required):
  ///
  /// * [DeleteUserFilesDto] deleteUserFilesDto (required):
  ///   Specify which files are to be deleted by sending the file field with a value of \"true\"
  Future<Response> deleteUserFilesWithHttpInfo(
    String userId,
    DeleteUserFilesDto deleteUserFilesDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}/files'.replaceAll('{userId}', userId);

    // ignore: prefer_final_locals
    Object? postBody = deleteUserFilesDto;

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
  /// * [String] userId (required):
  ///
  /// * [DeleteUserFilesDto] deleteUserFilesDto (required):
  ///   Specify which files are to be deleted by sending the file field with a value of \"true\"
  Future<void> deleteUserFiles(
    String userId,
    DeleteUserFilesDto deleteUserFilesDto,
  ) async {
    final response = await deleteUserFilesWithHttpInfo(
      userId,
      deleteUserFilesDto,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'DELETE /users/{userId}/profile/{profileId}/files' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userId (required):
  ///
  /// * [String] profileId (required):
  ///
  /// * [DeleteUserProfileFilesDto] deleteUserProfileFilesDto (required):
  ///   Specify which files are to be deleted by sending the file field with a value of \"true\"
  Future<Response> deleteUserProfileFilesWithHttpInfo(
    String userId,
    String profileId,
    DeleteUserProfileFilesDto deleteUserProfileFilesDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}/profile/{profileId}/files'
        .replaceAll('{userId}', userId)
        .replaceAll('{profileId}', profileId);

    // ignore: prefer_final_locals
    Object? postBody = deleteUserProfileFilesDto;

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
  /// * [String] userId (required):
  ///
  /// * [String] profileId (required):
  ///
  /// * [DeleteUserProfileFilesDto] deleteUserProfileFilesDto (required):
  ///   Specify which files are to be deleted by sending the file field with a value of \"true\"
  Future<void> deleteUserProfileFiles(
    String userId,
    String profileId,
    DeleteUserProfileFilesDto deleteUserProfileFilesDto,
  ) async {
    final response = await deleteUserProfileFilesWithHttpInfo(
      userId,
      profileId,
      deleteUserProfileFilesDto,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /users/{userId}/profile' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userId (required):
  Future<Response> getPublicUserWithHttpInfo(
    String userId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}/profile'.replaceAll('{userId}', userId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [String] userId (required):
  Future<PublicUser?> getPublicUser(
    String userId,
  ) async {
    final response = await getPublicUserWithHttpInfo(
      userId,
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
        'PublicUser',
      ) as PublicUser;
    }
    return null;
  }

  /// Performs an HTTP 'GET /users/{userId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userId (required):
  Future<Response> getUserByIdWithHttpInfo(
    String userId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}'.replaceAll('{userId}', userId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [String] userId (required):
  Future<User?> getUserById(
    String userId,
  ) async {
    final response = await getUserByIdWithHttpInfo(
      userId,
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
        'User',
      ) as User;
    }
    return null;
  }

  /// Performs an HTTP 'GET /users' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [num] page:
  ///
  /// * [num] perPage:
  ///
  /// * [String] search:
  ///   Searching is currently supported for only the displayName property
  Future<Response> getUsersWithHttpInfo({
    num? page,
    num? perPage,
    String? search,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/users';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (page != null) {
      queryParams.addAll(_queryParams('', 'page', page));
    }
    if (perPage != null) {
      queryParams.addAll(_queryParams('', 'perPage', perPage));
    }
    if (search != null) {
      queryParams.addAll(_queryParams('', 'search', search));
    }

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [num] page:
  ///
  /// * [num] perPage:
  ///
  /// * [String] search:
  ///   Searching is currently supported for only the displayName property
  Future<PaginatedUsers?> getUsers({
    num? page,
    num? perPage,
    String? search,
  }) async {
    final response = await getUsersWithHttpInfo(
      page: page,
      perPage: perPage,
      search: search,
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
        'PaginatedUsers',
      ) as PaginatedUsers;
    }
    return null;
  }

  /// Performs an HTTP 'PATCH /users/{userId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userId (required):
  ///
  /// * [PatchUserDto] patchUserDto (required):
  Future<Response> patchUserWithHttpInfo(
    String userId,
    PatchUserDto patchUserDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}'.replaceAll('{userId}', userId);

    // ignore: prefer_final_locals
    Object? postBody = patchUserDto;

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
  /// * [String] userId (required):
  ///
  /// * [PatchUserDto] patchUserDto (required):
  Future<PatchUserResponseDto?> patchUser(
    String userId,
    PatchUserDto patchUserDto,
  ) async {
    final response = await patchUserWithHttpInfo(
      userId,
      patchUserDto,
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
        'PatchUserResponseDto',
      ) as PatchUserResponseDto;
    }
    return null;
  }

  /// Performs an HTTP 'PATCH /users/{userId}/profile/{profileId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userId (required):
  ///
  /// * [String] profileId (required):
  ///
  /// * [PatchUserProfileDto] patchUserProfileDto (required):
  Future<Response> patchUserProfileWithHttpInfo(
    String userId,
    String profileId,
    PatchUserProfileDto patchUserProfileDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}/profile/{profileId}'
        .replaceAll('{userId}', userId)
        .replaceAll('{profileId}', profileId);

    // ignore: prefer_final_locals
    Object? postBody = patchUserProfileDto;

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
  /// * [String] userId (required):
  ///
  /// * [String] profileId (required):
  ///
  /// * [PatchUserProfileDto] patchUserProfileDto (required):
  Future<UserProfile?> patchUserProfile(
    String userId,
    String profileId,
    PatchUserProfileDto patchUserProfileDto,
  ) async {
    final response = await patchUserProfileWithHttpInfo(
      userId,
      profileId,
      patchUserProfileDto,
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
        'UserProfile',
      ) as UserProfile;
    }
    return null;
  }

  /// Performs an HTTP 'POST /users/{userId}/files' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userId (required):
  ///
  /// * [MultipartFile] avatar (required):
  Future<Response> postUserFilesWithHttpInfo(
    String userId,
    MultipartFile avatar,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}/files'.replaceAll('{userId}', userId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (avatar != null) {
      hasFields = true;
      mp.fields[r'avatar'] = avatar.field;
      mp.files.add(avatar);
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
  /// * [String] userId (required):
  ///
  /// * [MultipartFile] avatar (required):
  Future<void> postUserFiles(
    String userId,
    MultipartFile avatar,
  ) async {
    final response = await postUserFilesWithHttpInfo(
      userId,
      avatar,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /users/{userId}/profile/{profileId}/files' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] userId (required):
  ///
  /// * [String] profileId (required):
  ///
  /// * [MultipartFile] banner (required):
  Future<Response> postUserProfileFilesWithHttpInfo(
    String userId,
    String profileId,
    MultipartFile banner,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}/profile/{profileId}/files'
        .replaceAll('{userId}', userId)
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
  /// * [String] userId (required):
  ///
  /// * [String] profileId (required):
  ///
  /// * [MultipartFile] banner (required):
  Future<void> postUserProfileFiles(
    String userId,
    String profileId,
    MultipartFile banner,
  ) async {
    final response = await postUserProfileFilesWithHttpInfo(
      userId,
      profileId,
      banner,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
