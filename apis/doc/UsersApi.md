# qcarder_api.api.UsersApi

## Load the API package
```dart
import 'package:qcarder_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createUser**](UsersApi.md#createuser) | **POST** /users | 
[**editUser**](UsersApi.md#edituser) | **PATCH** /users/{userId} | 
[**editUserProfile**](UsersApi.md#edituserprofile) | **PATCH** /users/{userId}/profile/{profileId} | 
[**getMe**](UsersApi.md#getme) | **GET** /users/me | 
[**getUserById**](UsersApi.md#getuserbyid) | **GET** /users/{userId} | 
[**getUsers**](UsersApi.md#getusers) | **GET** /users | 


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

# **editUser**
> PatchUserResponseDto editUser(userId, patchUserDto)



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
final userId = 7; // num | 
final patchUserDto = PatchUserDto(); // PatchUserDto | 

try {
    final result = api_instance.editUser(userId, patchUserDto);
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->editUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **num**|  | [default to 1]
 **patchUserDto** | [**PatchUserDto**](PatchUserDto.md)|  | 

### Return type

[**PatchUserResponseDto**](PatchUserResponseDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **editUserProfile**
> UserProfile editUserProfile(userId, profileId, patchUserProfileDto)



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
final userId = 13; // num | 
final profileId = 13; // num | 
final patchUserProfileDto = PatchUserProfileDto(); // PatchUserProfileDto | 

try {
    final result = api_instance.editUserProfile(userId, profileId, patchUserProfileDto);
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->editUserProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **num**|  | 
 **profileId** | **num**|  | 
 **patchUserProfileDto** | [**PatchUserProfileDto**](PatchUserProfileDto.md)|  | 

### Return type

[**UserProfile**](UserProfile.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMe**
> User getMe()



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

try {
    final result = api_instance.getMe();
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->getMe: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**User**](User.md)

### Authorization

[bearer](../README.md#bearer)

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
final userId = 13; // num | 

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
 **userId** | **num**|  | 

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

