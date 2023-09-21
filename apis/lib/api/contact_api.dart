//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ContactApi {
  ContactApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /contact' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [PostContactFormDto] postContactFormDto (required):
  Future<Response> postContactFormWithHttpInfo(
    PostContactFormDto postContactFormDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/contact';

    // ignore: prefer_final_locals
    Object? postBody = postContactFormDto;

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
  /// * [PostContactFormDto] postContactFormDto (required):
  Future<void> postContactForm(
    PostContactFormDto postContactFormDto,
  ) async {
    final response = await postContactFormWithHttpInfo(
      postContactFormDto,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
