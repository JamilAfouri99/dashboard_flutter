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
  Future<Response> createUserWithHttpInfo(PostUserDto postUserDto,) async {
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
  Future<User?> createUser(PostUserDto postUserDto,) async {
    final response = await createUserWithHttpInfo(postUserDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'User',) as User;
    
    }
    return null;
  }

  /// Performs an HTTP 'PATCH /users/{userId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [num] userId (required):
  ///
  /// * [PatchUserDto] patchUserDto (required):
  Future<Response> editUserWithHttpInfo(num userId, PatchUserDto patchUserDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}'
      .replaceAll('{userId}', userId.toString());

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
  /// * [num] userId (required):
  ///
  /// * [PatchUserDto] patchUserDto (required):
  Future<PatchUserResponseDto?> editUser(num userId, PatchUserDto patchUserDto,) async {
    final response = await editUserWithHttpInfo(userId, patchUserDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PatchUserResponseDto',) as PatchUserResponseDto;
    
    }
    return null;
  }

  /// Performs an HTTP 'PATCH /users/{userId}/profile/{profileId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [num] userId (required):
  ///
  /// * [num] profileId (required):
  ///
  /// * [PatchUserProfileDto] patchUserProfileDto (required):
  Future<Response> editUserProfileWithHttpInfo(num userId, num profileId, PatchUserProfileDto patchUserProfileDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}/profile/{profileId}'
      .replaceAll('{userId}', userId.toString())
      .replaceAll('{profileId}', profileId.toString());

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
  /// * [num] userId (required):
  ///
  /// * [num] profileId (required):
  ///
  /// * [PatchUserProfileDto] patchUserProfileDto (required):
  Future<UserProfile?> editUserProfile(num userId, num profileId, PatchUserProfileDto patchUserProfileDto,) async {
    final response = await editUserProfileWithHttpInfo(userId, profileId, patchUserProfileDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UserProfile',) as UserProfile;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /users/me' operation and returns the [Response].
  Future<Response> getMeWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/users/me';

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

  Future<User?> getMe() async {
    final response = await getMeWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'User',) as User;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /users/{userId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [num] userId (required):
  Future<Response> getUserByIdWithHttpInfo(num userId,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{userId}'
      .replaceAll('{userId}', userId.toString());

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
  /// * [num] userId (required):
  Future<User?> getUserById(num userId,) async {
    final response = await getUserByIdWithHttpInfo(userId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'User',) as User;
    
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
  Future<Response> getUsersWithHttpInfo({ num? page, num? perPage, String? search, }) async {
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
  Future<PaginatedUsers?> getUsers({ num? page, num? perPage, String? search, }) async {
    final response = await getUsersWithHttpInfo( page: page, perPage: perPage, search: search, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PaginatedUsers',) as PaginatedUsers;
    
    }
    return null;
  }
}
