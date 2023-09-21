//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PatchUserResponseDto {
  /// Returns a new [PatchUserResponseDto] instance.
  PatchUserResponseDto({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.role,
    this.status,
    this.groupId,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? updatedAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? firstName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lastName;

  String? avatar;

  PatchUserResponseDtoRoleEnum? role;

  PatchUserResponseDtoStatusEnum? status;

  String? groupId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatchUserResponseDto &&
          other.id == id &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.email == email &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.avatar == avatar &&
          other.role == role &&
          other.status == status &&
          other.groupId == groupId;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id == null ? 0 : id!.hashCode) +
      (createdAt == null ? 0 : createdAt!.hashCode) +
      (updatedAt == null ? 0 : updatedAt!.hashCode) +
      (email == null ? 0 : email!.hashCode) +
      (firstName == null ? 0 : firstName!.hashCode) +
      (lastName == null ? 0 : lastName!.hashCode) +
      (avatar == null ? 0 : avatar!.hashCode) +
      (role == null ? 0 : role!.hashCode) +
      (status == null ? 0 : status!.hashCode) +
      (groupId == null ? 0 : groupId!.hashCode);

  @override
  String toString() =>
      'PatchUserResponseDto[id=$id, createdAt=$createdAt, updatedAt=$updatedAt, email=$email, firstName=$firstName, lastName=$lastName, avatar=$avatar, role=$role, status=$status, groupId=$groupId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt!.toUtc().toIso8601String();
    } else {
      json[r'updatedAt'] = null;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.firstName != null) {
      json[r'firstName'] = this.firstName;
    } else {
      json[r'firstName'] = null;
    }
    if (this.lastName != null) {
      json[r'lastName'] = this.lastName;
    } else {
      json[r'lastName'] = null;
    }
    if (this.avatar != null) {
      json[r'avatar'] = this.avatar;
    } else {
      json[r'avatar'] = null;
    }
    if (this.role != null) {
      json[r'role'] = this.role;
    } else {
      json[r'role'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.groupId != null) {
      json[r'groupId'] = this.groupId;
    } else {
      json[r'groupId'] = null;
    }
    return json;
  }

  /// Returns a new [PatchUserResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PatchUserResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "PatchUserResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "PatchUserResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PatchUserResponseDto(
        id: mapValueOfType<String>(json, r'id'),
        createdAt: mapDateTime(json, r'createdAt', ''),
        updatedAt: mapDateTime(json, r'updatedAt', ''),
        email: mapValueOfType<String>(json, r'email'),
        firstName: mapValueOfType<String>(json, r'firstName'),
        lastName: mapValueOfType<String>(json, r'lastName'),
        avatar: mapValueOfType<String>(json, r'avatar'),
        role: PatchUserResponseDtoRoleEnum.fromJson(json[r'role']),
        status: PatchUserResponseDtoStatusEnum.fromJson(json[r'status']),
        groupId: mapValueOfType<String>(json, r'groupId'),
      );
    }
    return null;
  }

  static List<PatchUserResponseDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PatchUserResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PatchUserResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PatchUserResponseDto> mapFromJson(dynamic json) {
    final map = <String, PatchUserResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PatchUserResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PatchUserResponseDto-objects as value to a dart map
  static Map<String, List<PatchUserResponseDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PatchUserResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PatchUserResponseDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{};
}

class PatchUserResponseDtoRoleEnum {
  /// Instantiate a new enum with the provided [value].
  const PatchUserResponseDtoRoleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const USER = PatchUserResponseDtoRoleEnum._(r'USER');
  static const OWNER = PatchUserResponseDtoRoleEnum._(r'OWNER');
  static const ADMIN = PatchUserResponseDtoRoleEnum._(r'ADMIN');
  static const SUPERADMIN = PatchUserResponseDtoRoleEnum._(r'SUPERADMIN');

  /// List of all possible values in this [enum][PatchUserResponseDtoRoleEnum].
  static const values = <PatchUserResponseDtoRoleEnum>[
    USER,
    OWNER,
    ADMIN,
    SUPERADMIN,
  ];

  static PatchUserResponseDtoRoleEnum? fromJson(dynamic value) =>
      PatchUserResponseDtoRoleEnumTypeTransformer().decode(value);

  static List<PatchUserResponseDtoRoleEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PatchUserResponseDtoRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PatchUserResponseDtoRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PatchUserResponseDtoRoleEnum] to String,
/// and [decode] dynamic data back to [PatchUserResponseDtoRoleEnum].
class PatchUserResponseDtoRoleEnumTypeTransformer {
  factory PatchUserResponseDtoRoleEnumTypeTransformer() =>
      _instance ??= const PatchUserResponseDtoRoleEnumTypeTransformer._();

  const PatchUserResponseDtoRoleEnumTypeTransformer._();

  String encode(PatchUserResponseDtoRoleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a PatchUserResponseDtoRoleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PatchUserResponseDtoRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'USER':
          return PatchUserResponseDtoRoleEnum.USER;
        case r'OWNER':
          return PatchUserResponseDtoRoleEnum.OWNER;
        case r'ADMIN':
          return PatchUserResponseDtoRoleEnum.ADMIN;
        case r'SUPERADMIN':
          return PatchUserResponseDtoRoleEnum.SUPERADMIN;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [PatchUserResponseDtoRoleEnumTypeTransformer] instance.
  static PatchUserResponseDtoRoleEnumTypeTransformer? _instance;
}

class PatchUserResponseDtoStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const PatchUserResponseDtoStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ACTIVE = PatchUserResponseDtoStatusEnum._(r'ACTIVE');
  static const INACTIVE = PatchUserResponseDtoStatusEnum._(r'INACTIVE');

  /// List of all possible values in this [enum][PatchUserResponseDtoStatusEnum].
  static const values = <PatchUserResponseDtoStatusEnum>[
    ACTIVE,
    INACTIVE,
  ];

  static PatchUserResponseDtoStatusEnum? fromJson(dynamic value) =>
      PatchUserResponseDtoStatusEnumTypeTransformer().decode(value);

  static List<PatchUserResponseDtoStatusEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PatchUserResponseDtoStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PatchUserResponseDtoStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PatchUserResponseDtoStatusEnum] to String,
/// and [decode] dynamic data back to [PatchUserResponseDtoStatusEnum].
class PatchUserResponseDtoStatusEnumTypeTransformer {
  factory PatchUserResponseDtoStatusEnumTypeTransformer() =>
      _instance ??= const PatchUserResponseDtoStatusEnumTypeTransformer._();

  const PatchUserResponseDtoStatusEnumTypeTransformer._();

  String encode(PatchUserResponseDtoStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a PatchUserResponseDtoStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PatchUserResponseDtoStatusEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ACTIVE':
          return PatchUserResponseDtoStatusEnum.ACTIVE;
        case r'INACTIVE':
          return PatchUserResponseDtoStatusEnum.INACTIVE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [PatchUserResponseDtoStatusEnumTypeTransformer] instance.
  static PatchUserResponseDtoStatusEnumTypeTransformer? _instance;
}
