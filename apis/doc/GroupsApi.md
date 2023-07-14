# qcarder_api.api.GroupsApi

## Load the API package
```dart
import 'package:qcarder_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteUserProfileFiles**](GroupsApi.md#deleteuserprofilefiles) | **DELETE** /groups/{userId}/profile/{profileId}/files | 
[**patchUserGroup**](GroupsApi.md#patchusergroup) | **PATCH** /groups/{groupId} | 
[**postGroupFiles**](GroupsApi.md#postgroupfiles) | **POST** /groups/{groupId}/profile/{profileId}/files | 


# **deleteUserProfileFiles**
> deleteUserProfileFiles(groupId, profileId, deleteGroupProfileFilesDto)



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = GroupsApi();
final groupId = xXx7xXx7xXx7xXx7; // String | 
final profileId = xXx7xXx7xXx7xXx7; // String | 
final deleteGroupProfileFilesDto = DeleteGroupProfileFilesDto(); // DeleteGroupProfileFilesDto | Specify which files are to be deleted by sending the file field with a value of \"true\" 

try {
    api_instance.deleteUserProfileFiles(groupId, profileId, deleteGroupProfileFilesDto);
} catch (e) {
    print('Exception when calling GroupsApi->deleteUserProfileFiles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **String**|  | 
 **profileId** | **String**|  | 
 **deleteGroupProfileFilesDto** | [**DeleteGroupProfileFilesDto**](DeleteGroupProfileFilesDto.md)| Specify which files are to be deleted by sending the file field with a value of \"true\"  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **patchUserGroup**
> PatchGroupResponseDto patchUserGroup(groupId, patchGroupDto)



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = GroupsApi();
final groupId = xXx7xXx7xXx7xXx7; // String | 
final patchGroupDto = PatchGroupDto(); // PatchGroupDto | 

try {
    final result = api_instance.patchUserGroup(groupId, patchGroupDto);
    print(result);
} catch (e) {
    print('Exception when calling GroupsApi->patchUserGroup: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **String**|  | 
 **patchGroupDto** | [**PatchGroupDto**](PatchGroupDto.md)|  | 

### Return type

[**PatchGroupResponseDto**](PatchGroupResponseDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postGroupFiles**
> postGroupFiles(groupId, profileId, banner)



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = GroupsApi();
final groupId = xXx7xXx7xXx7xXx7; // String | 
final profileId = xXx7xXx7xXx7xXx7; // String | 
final banner = BINARY_DATA_HERE; // MultipartFile | 

try {
    api_instance.postGroupFiles(groupId, profileId, banner);
} catch (e) {
    print('Exception when calling GroupsApi->postGroupFiles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **String**|  | 
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

