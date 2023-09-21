# qcarder_api.api.ContactApi

## Load the API package
```dart
import 'package:qcarder_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**postContactForm**](ContactApi.md#postcontactform) | **POST** /contact | 


# **postContactForm**
> postContactForm(postContactFormDto)



### Example
```dart
import 'package:qcarder_api/api.dart';

final api_instance = ContactApi();
final postContactFormDto = PostContactFormDto(); // PostContactFormDto | 

try {
    api_instance.postContactForm(postContactFormDto);
} catch (e) {
    print('Exception when calling ContactApi->postContactForm: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postContactFormDto** | [**PostContactFormDto**](PostContactFormDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

