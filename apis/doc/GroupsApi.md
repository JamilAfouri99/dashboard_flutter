# qcarder_api.api.GroupsApi

## Load the API package
```dart
import 'package:qcarder_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**patchUserGroup**](GroupsApi.md#patchusergroup) | **PATCH** /groups/{groupId} | 
[**postGroupFiles**](GroupsApi.md#postgroupfiles) | **POST** /groups/{groupId}/files | 


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
final groupId = 7; // String | 
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
 **groupId** | **String**|  | [default to '1']
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
> postGroupFiles(groupId, banner)



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
final groupId = 7; // String | 
final banner = BINARY_DATA_HERE; // MultipartFile | 

try {
    api_instance.postGroupFiles(groupId, banner);
} catch (e) {
    print('Exception when calling GroupsApi->postGroupFiles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **groupId** | **String**|  | [default to '1']
 **banner** | **MultipartFile**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

