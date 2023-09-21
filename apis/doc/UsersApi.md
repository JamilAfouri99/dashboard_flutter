# qcarder_api.api.UsersApi

## Load the API package
```dart
import 'package:qcarder_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createUser**](UsersApi.md#createuser) | **POST** /users | 
[**deleteUser**](UsersApi.md#deleteuser) | **DELETE** /users/{userId} | 
[**deleteUserFiles**](UsersApi.md#deleteuserfiles) | **DELETE** /users/{userId}/files | 
[**deleteUserProfileFiles**](UsersApi.md#deleteuserprofilefiles) | **DELETE** /users/{userId}/profile/{profileId}/files | 
[**getPublicUser**](UsersApi.md#getpublicuser) | **GET** /users/{userId}/profile | 
[**getUserById**](UsersApi.md#getuserbyid) | **GET** /users/{userId} | 
[**getUsers**](UsersApi.md#getusers) | **GET** /users | 
[**patchUser**](UsersApi.md#patchuser) | **PATCH** /users/{userId} | 
[**patchUserProfile**](UsersApi.md#patchuserprofile) | **PATCH** /users/{userId}/profile/{profileId} | 
[**postUserFiles**](UsersApi.md#postuserfiles) | **POST** /users/{userId}/files | 
[**postUserProfileFiles**](UsersApi.md#postuserprofilefiles) | **POST** /users/{userId}/profile/{profileId}/files | 


# **createUser**
> User createUser(postUserDto)



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = UsersApi();
final postUserDto = PostUserDto(); // PostUserDto | 

try {
    final result = api_instance.createUser(postUserDto);
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->createUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postUserDto** | [**PostUserDto**](PostUserDto.md)|  | 

### Return type

[**User**](User.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteUser**
> deleteUser(userId)



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = UsersApi();
final userId = xXx7xXx7xXx7xXx7; // String | 

try {
    api_instance.deleteUser(userId);
} catch (e) {
    print('Exception when calling UsersApi->deleteUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteUserFiles**
> deleteUserFiles(userId, deleteUserFilesDto)



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = UsersApi();
final userId = xXx7xXx7xXx7xXx7; // String | 
final deleteUserFilesDto = DeleteUserFilesDto(); // DeleteUserFilesDto | Specify which files are to be deleted by sending the file field with a value of \"true\" 

try {
    api_instance.deleteUserFiles(userId, deleteUserFilesDto);
} catch (e) {
    print('Exception when calling UsersApi->deleteUserFiles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **deleteUserFilesDto** | [**DeleteUserFilesDto**](DeleteUserFilesDto.md)| Specify which files are to be deleted by sending the file field with a value of \"true\"  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteUserProfileFiles**
> deleteUserProfileFiles(userId, profileId, deleteUserProfileFilesDto)



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = UsersApi();
final userId = xXx7xXx7xXx7xXx7; // String | 
final profileId = xXx7xXx7xXx7xXx7; // String | 
final deleteUserProfileFilesDto = DeleteUserProfileFilesDto(); // DeleteUserProfileFilesDto | Specify which files are to be deleted by sending the file field with a value of \"true\" 

try {
    api_instance.deleteUserProfileFiles(userId, profileId, deleteUserProfileFilesDto);
} catch (e) {
    print('Exception when calling UsersApi->deleteUserProfileFiles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **profileId** | **String**|  | 
 **deleteUserProfileFilesDto** | [**DeleteUserProfileFilesDto**](DeleteUserProfileFilesDto.md)| Specify which files are to be deleted by sending the file field with a value of \"true\"  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPublicUser**
> PublicUser getPublicUser(userId)



### Example
```dart
import 'package:qcarder_api/api.dart';

final api_instance = UsersApi();
final userId = xXx7xXx7xXx7xXx7; // String | 

try {
    final result = api_instance.getPublicUser(userId);
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->getPublicUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

[**PublicUser**](PublicUser.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserById**
> User getUserById(userId)



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = UsersApi();
final userId = xXx7xXx7xXx7xXx7; // String | 

try {
    final result = api_instance.getUserById(userId);
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->getUserById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

[**User**](User.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUsers**
> PaginatedUsers getUsers(page, perPage, search)



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = UsersApi();
final page = 7; // num | 
final perPage = 5; // num | 
final search = Display Name; // String | Searching is currently supported for only the displayName property

try {
    final result = api_instance.getUsers(page, perPage, search);
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->getUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**|  | [optional] [default to 1]
 **perPage** | **num**|  | [optional] [default to 20]
 **search** | **String**| Searching is currently supported for only the displayName property | [optional] 

### Return type

[**PaginatedUsers**](PaginatedUsers.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **patchUser**
> PatchUserResponseDto patchUser(userId, patchUserDto)



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = UsersApi();
final userId = xXx7xXx7xXx7xXx7; // String | 
final patchUserDto = PatchUserDto(); // PatchUserDto | 

try {
    final result = api_instance.patchUser(userId, patchUserDto);
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->patchUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **patchUserDto** | [**PatchUserDto**](PatchUserDto.md)|  | 

### Return type

[**PatchUserResponseDto**](PatchUserResponseDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **patchUserProfile**
> UserProfile patchUserProfile(userId, profileId, patchUserProfileDto)



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = UsersApi();
final userId = xXx7xXx7xXx7xXx7; // String | 
final profileId = xXx7xXx7xXx7xXx7; // String | 
final patchUserProfileDto = PatchUserProfileDto(); // PatchUserProfileDto | 

try {
    final result = api_instance.patchUserProfile(userId, profileId, patchUserProfileDto);
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->patchUserProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **profileId** | **String**|  | 
 **patchUserProfileDto** | [**PatchUserProfileDto**](PatchUserProfileDto.md)|  | 

### Return type

[**UserProfile**](UserProfile.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postUserFiles**
> postUserFiles(userId, avatar)



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = UsersApi();
final userId = xXx7xXx7xXx7xXx7; // String | 
final avatar = BINARY_DATA_HERE; // MultipartFile | 

try {
    api_instance.postUserFiles(userId, avatar);
} catch (e) {
    print('Exception when calling UsersApi->postUserFiles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **avatar** | **MultipartFile**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postUserProfileFiles**
> postUserProfileFiles(userId, profileId, banner)



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = UsersApi();
final userId = xXx7xXx7xXx7xXx7; // String | 
final profileId = xXx7xXx7xXx7xXx7; // String | 
final banner = BINARY_DATA_HERE; // MultipartFile | 

try {
    api_instance.postUserProfileFiles(userId, profileId, banner);
} catch (e) {
    print('Exception when calling UsersApi->postUserProfileFiles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **profileId** | **String**|  | 
 **banner** | **MultipartFile**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

