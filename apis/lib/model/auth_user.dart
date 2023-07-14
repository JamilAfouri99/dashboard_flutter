//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AuthUser {
  /// Returns a new [AuthUser] instance.
  AuthUser({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.avatar,
    required this.role,
    required this.status,
    this.groupId,
    required this.accessToken,
    required this.refreshToken,
  });

  String id;

  DateTime createdAt;

  DateTime updatedAt;

  String email;

  String firstName;

  String lastName;

  String? avatar;

  AuthUserRoleEnum role;

  AuthUserStatusEnum status;

  String? groupId;

  String accessToken;

  String refreshToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUser &&
          other.id == id &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.email == email &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.avatar == avatar &&
          other.role == role &&
          other.status == status &&
          other.groupId == groupId &&
          other.accessToken == accessToken &&
          other.refreshToken == refreshToken;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id.hashCode) +
      (createdAt.hashCode) +
      (updatedAt.hashCode) +
      (email.hashCode) +
      (firstName.hashCode) +
      (lastName.hashCode) +
      (avatar == null ? 0 : avatar!.hashCode) +
      (role.hashCode) +
      (status.hashCode) +
      (groupId == null ? 0 : groupId!.hashCode) +
      (accessToken.hashCode) +
      (refreshToken.hashCode);

  @override
  String toString() =>
      'AuthUser[id=$id, createdAt=$createdAt, updatedAt=$updatedAt, email=$email, firstName=$firstName, lastName=$lastName, avatar=$avatar, role=$role, status=$status, groupId=$groupId, accessToken=$accessToken, refreshToken=$refreshToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = this.id;
    json[r'createdAt'] = this.createdAt.toUtc().toIso8601String();
    json[r'updatedAt'] = this.updatedAt.toUtc().toIso8601String();
    json[r'email'] = this.email;
    json[r'firstName'] = this.firstName;
    json[r'lastName'] = this.lastName;
    if (this.avatar != null) {
      json[r'avatar'] = this.avatar;
    } else {
      json[r'avatar'] = null;
    }
    json[r'role'] = this.role;
    json[r'status'] = this.status;
    if (this.groupId != null) {
      json[r'groupId'] = this.groupId;
    } else {
      json[r'groupId'] = null;
    }
    json[r'access_token'] = this.accessToken;
    json[r'refresh_token'] = this.refreshToken;
    return json;
  }

  /// Returns a new [AuthUser] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AuthUser? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AuthUser[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AuthUser[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AuthUser(
        id: mapValueOfType<String>(json, r'id')!,
        createdAt: mapDateTime(json, r'createdAt', '')!,
        updatedAt: mapDateTime(json, r'updatedAt', '')!,
        email: mapValueOfType<String>(json, r'email')!,
        firstName: mapValueOfType<String>(json, r'firstName')!,
        lastName: mapValueOfType<String>(json, r'lastName')!,
        avatar: json[r'avatar'] == null ? null : mapValueOfType<String>(json, r'avatar'),
        role: AuthUserRoleEnum.fromJson(json[r'role'])!,
        status: AuthUserStatusEnum.fromJson(json[r'status'])!,
        groupId: json[r'groupId'] == null ? null : json[r'groupId'],
        accessToken: mapValueOfType<String>(json, r'access_token')!,
        refreshToken: mapValueOfType<String>(json, r'refresh_token')!,
      );
    }
    return null;
  }

  static List<AuthUser>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AuthUser>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuthUser.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AuthUser> mapFromJson(dynamic json) {
    final map = <String, AuthUser>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AuthUser.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AuthUser-objects as value to a dart map
  static Map<String, List<AuthUser>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<AuthUser>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AuthUser.listFromJson(
          entry.value,
          growable: growable,
        );
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'createdAt',
    'updatedAt',
    'email',
    'firstName',
    'lastName',
    'role',
    'status',
    'access_token',
    'refresh_token',
  };
}

class AuthUserRoleEnum {
  /// Instantiate a new enum with the provided [value].
  const AuthUserRoleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const USER = AuthUserRoleEnum._(r'USER');
  static const OWNER = AuthUserRoleEnum._(r'OWNER');
  static const ADMIN = AuthUserRoleEnum._(r'ADMIN');
  static const SUPERADMIN = AuthUserRoleEnum._(r'SUPERADMIN');

  /// List of all possible values in this [enum][AuthUserRoleEnum].
  static const values = <AuthUserRoleEnum>[
    USER,
    OWNER,
    ADMIN,
    SUPERADMIN,
  ];

  static AuthUserRoleEnum? fromJson(dynamic value) =>
      AuthUserRoleEnumTypeTransformer().decode(value);

  static List<AuthUserRoleEnum>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AuthUserRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuthUserRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AuthUserRoleEnum] to String,
/// and [decode] dynamic data back to [AuthUserRoleEnum].
class AuthUserRoleEnumTypeTransformer {
  factory AuthUserRoleEnumTypeTransformer() =>
      _instance ??= const AuthUserRoleEnumTypeTransformer._();

  const AuthUserRoleEnumTypeTransformer._();

  String encode(AuthUserRoleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a AuthUserRoleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AuthUserRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'USER':
          return AuthUserRoleEnum.USER;
        case r'OWNER':
          return AuthUserRoleEnum.OWNER;
        case r'ADMIN':
          return AuthUserRoleEnum.ADMIN;
        case r'SUPERADMIN':
          return AuthUserRoleEnum.SUPERADMIN;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AuthUserRoleEnumTypeTransformer] instance.
  static AuthUserRoleEnumTypeTransformer? _instance;
}

class AuthUserStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const AuthUserStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ACTIVE = AuthUserStatusEnum._(r'ACTIVE');
  static const INACTIVE = AuthUserStatusEnum._(r'INACTIVE');

  /// List of all possible values in this [enum][AuthUserStatusEnum].
  static const values = <AuthUserStatusEnum>[
    ACTIVE,
    INACTIVE,
  ];

  static AuthUserStatusEnum? fromJson(dynamic value) =>
      AuthUserStatusEnumTypeTransformer().decode(value);

  static List<AuthUserStatusEnum>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AuthUserStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuthUserStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AuthUserStatusEnum] to String,
/// and [decode] dynamic data back to [AuthUserStatusEnum].
class AuthUserStatusEnumTypeTransformer {
  factory AuthUserStatusEnumTypeTransformer() =>
      _instance ??= const AuthUserStatusEnumTypeTransformer._();

  const AuthUserStatusEnumTypeTransformer._();

  String encode(AuthUserStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a AuthUserStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AuthUserStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ACTIVE':
          return AuthUserStatusEnum.ACTIVE;
        case r'INACTIVE':
          return AuthUserStatusEnum.INACTIVE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AuthUserStatusEnumTypeTransformer] instance.
  static AuthUserStatusEnumTypeTransformer? _instance;
}
