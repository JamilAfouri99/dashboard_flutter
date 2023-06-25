# qcarder_api.api.AuthApi

## Load the API package
```dart
import 'package:qcarder_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**logout**](AuthApi.md#logout) | **POST** /auth/logout | 
[**signin**](AuthApi.md#signin) | **POST** /auth/signin | 
[**signinUsingAccessToken**](AuthApi.md#signinusingaccesstoken) | **POST** /auth/signin/access-token | 
[**signinUsingRefreshToken**](AuthApi.md#signinusingrefreshtoken) | **POST** /auth/signin/refresh-token | 
[**signup**](AuthApi.md#signup) | **POST** /auth/signup | 


# **logout**
> logout()



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AuthApi();

try {
    api_instance.logout();
} catch (e) {
    print('Exception when calling AuthApi->logout: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signin**
> AuthUser signin(signinDto)



### Example
```dart
import 'package:qcarder_api/api.dart';

final api_instance = AuthApi();
final signinDto = SigninDto(); // SigninDto | 

try {
    final result = api_instance.signin(signinDto);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->signin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **signinDto** | [**SigninDto**](SigninDto.md)|  | 

### Return type

[**AuthUser**](AuthUser.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signinUsingAccessToken**
> AuthUser signinUsingAccessToken()



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AuthApi();

try {
    final result = api_instance.signinUsingAccessToken();
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->signinUsingAccessToken: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AuthUser**](AuthUser.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signinUsingRefreshToken**
> AuthUser signinUsingRefreshToken()



### Example
```dart
import 'package:qcarder_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearer
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearer').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AuthApi();

try {
    final result = api_instance.signinUsingRefreshToken();
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->signinUsingRefreshToken: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AuthUser**](AuthUser.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signup**
> AuthUser signup(signupDto)



### Example
```dart
import 'package:qcarder_api/api.dart';

final api_instance = AuthApi();
final signupDto = SignupDto(); // SignupDto | 

try {
    final result = api_instance.signup(signupDto);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->signup: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **signupDto** | [**SignupDto**](SignupDto.md)|  | 

### Return type

[**AuthUser**](AuthUser.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

