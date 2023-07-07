//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class User {
  /// Returns a new [User] instance.
  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.status,
    required this.profile,
    this.avatar,
    this.group,
    this.groupId,
  });

  String id;

  DateTime createdAt;

  DateTime updatedAt;

  String email;

  String firstName;

  String lastName;

  String? avatar;

  UserRoleEnum role;

  UserStatusEnum status;

  Group? group;

  String? groupId;

  UserProfile profile;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          other.id == id &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.email == email &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.avatar == avatar &&
          other.role == role &&
          other.status == status &&
          other.group == group &&
          other.groupId == groupId &&
          other.profile == profile;

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
      (group == null ? 0 : group!.hashCode) +
      (groupId == null ? 0 : groupId!.hashCode) +
      (profile.hashCode);

  @override
  String toString() =>
      'User[id=$id, createdAt=$createdAt, updatedAt=$updatedAt, email=$email, firstName=$firstName, lastName=$lastName, avatar=$avatar, role=$role, status=$status, group=$group, groupId=$groupId, profile=$profile]';

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
    if (this.group != null) {
      json[r'group'] = this.group;
    } else {
      json[r'group'] = null;
    }
    if (this.groupId != null) {
      json[r'groupId'] = this.groupId;
    } else {
      json[r'groupId'] = null;
    }
    json[r'profile'] = this.profile;
    return json;
  }

  /// Returns a new [User] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static User? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "User[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "User[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return User(
        id: mapValueOfType<String>(json, r'id')!,
        createdAt: mapDateTime(json, r'createdAt', '')!,
        updatedAt: mapDateTime(json, r'updatedAt', '')!,
        email: mapValueOfType<String>(json, r'email')!,
        firstName: mapValueOfType<String>(json, r'firstName')!,
        lastName: mapValueOfType<String>(json, r'lastName')!,
        avatar: json[r'avatar'] != null ? mapValueOfType<String>(json, r'avatar') : null,
        role: UserRoleEnum.fromJson(json[r'role'])!,
        status: UserStatusEnum.fromJson(json[r'status'])!,
        group: json[r'group'] != null ? Group.fromJson(json[r'group']) : null,
        groupId: json[r'groupId'],
        profile: UserProfile.fromJson(json[r'profile'])!,
      );
    }
    return null;
  }

  static List<User>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <User>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = User.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, User> mapFromJson(dynamic json) {
    final map = <String, User>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = User.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of User-objects as value to a dart map
  static Map<String, List<User>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<User>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = User.listFromJson(
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
    'profile',
  };
}

class UserRoleEnum {
  /// Instantiate a new enum with the provided [value].
  const UserRoleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const USER = UserRoleEnum._(r'USER');
  static const OWNER = UserRoleEnum._(r'OWNER');
  static const ADMIN = UserRoleEnum._(r'ADMIN');
  static const SUPERADMIN = UserRoleEnum._(r'SUPERADMIN');

  /// List of all possible values in this [enum][UserRoleEnum].
  static const values = <UserRoleEnum>[
    USER,
    OWNER,
    ADMIN,
    SUPERADMIN,
  ];

  static UserRoleEnum? fromJson(dynamic value) => UserRoleEnumTypeTransformer().decode(value);

  static List<UserRoleEnum>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <UserRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UserRoleEnum] to String,
/// and [decode] dynamic data back to [UserRoleEnum].
class UserRoleEnumTypeTransformer {
  factory UserRoleEnumTypeTransformer() => _instance ??= const UserRoleEnumTypeTransformer._();

  const UserRoleEnumTypeTransformer._();

  String encode(UserRoleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UserRoleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UserRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'USER':
          return UserRoleEnum.USER;
        case r'OWNER':
          return UserRoleEnum.OWNER;
        case r'ADMIN':
          return UserRoleEnum.ADMIN;
        case r'SUPERADMIN':
          return UserRoleEnum.SUPERADMIN;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UserRoleEnumTypeTransformer] instance.
  static UserRoleEnumTypeTransformer? _instance;
}

class UserStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const UserStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ACTIVE = UserStatusEnum._(r'ACTIVE');
  static const INACTIVE = UserStatusEnum._(r'INACTIVE');

  /// List of all possible values in this [enum][UserStatusEnum].
  static const values = <UserStatusEnum>[
    ACTIVE,
    INACTIVE,
  ];

  static UserStatusEnum? fromJson(dynamic value) => UserStatusEnumTypeTransformer().decode(value);

  static List<UserStatusEnum>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <UserStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UserStatusEnum] to String,
/// and [decode] dynamic data back to [UserStatusEnum].
class UserStatusEnumTypeTransformer {
  factory UserStatusEnumTypeTransformer() => _instance ??= const UserStatusEnumTypeTransformer._();

  const UserStatusEnumTypeTransformer._();

  String encode(UserStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UserStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UserStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ACTIVE':
          return UserStatusEnum.ACTIVE;
        case r'INACTIVE':
          return UserStatusEnum.INACTIVE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UserStatusEnumTypeTransformer] instance.
  static UserStatusEnumTypeTransformer? _instance;
}
