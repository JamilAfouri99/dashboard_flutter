//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/api_health_check_api.dart';
part 'api/auth_api.dart';
part 'api/groups_api.dart';
part 'api/users_api.dart';

part 'model/auth_user.dart';
part 'model/delete_group_profile_files_dto.dart';
part 'model/delete_user_files_dto.dart';
part 'model/delete_user_profile_files_dto.dart';
part 'model/email.dart';
part 'model/group.dart';
part 'model/group_profile.dart';
part 'model/link.dart';
part 'model/paginated_users.dart';
part 'model/pagination_meta_data.dart';
part 'model/patch_group_dto.dart';
part 'model/patch_group_response_dto.dart';
part 'model/patch_user_dto.dart';
part 'model/patch_user_profile_dto.dart';
part 'model/patch_user_response_dto.dart';
part 'model/phone_number.dart';
part 'model/post_user_dto.dart';
part 'model/signin_dto.dart';
part 'model/signup_dto.dart';
part 'model/unauthorized.dart';
part 'model/user.dart';
part 'model/user_profile.dart';


const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ApiClient defaultApiClient = ApiClient();
