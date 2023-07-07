//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PatchUserDto {
  /// Returns a new [PatchUserDto] instance.
  PatchUserDto({
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.status,
  });

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

  PatchUserDtoRoleEnum? role;

  PatchUserDtoStatusEnum? status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatchUserDto &&
          other.email == email &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.role == role &&
          other.status == status;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (email == null ? 0 : email!.hashCode) +
      (firstName == null ? 0 : firstName!.hashCode) +
      (lastName == null ? 0 : lastName!.hashCode) +
      (role == null ? 0 : role!.hashCode) +
      (status == null ? 0 : status!.hashCode);

  @override
  String toString() =>
      'PatchUserDto[email=$email, firstName=$firstName, lastName=$lastName, role=$role, status=$status]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
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
    return json;
  }

  /// Returns a new [PatchUserDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PatchUserDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PatchUserDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PatchUserDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PatchUserDto(
        email: json[r'email'] == null ? null : mapValueOfType<String>(json, r'email'),
        firstName: json[r'firstName'] == null ? null : mapValueOfType<String>(json, r'firstName'),
        lastName: json[r'lastName'] == null ? null : mapValueOfType<String>(json, r'lastName'),
        role: json[r'role'] == null ? null : PatchUserDtoRoleEnum.fromJson(json[r'role']),
        status: json[r'status'] == null ? null : PatchUserDtoStatusEnum.fromJson(json[r'status']),
      );
    }
    return null;
  }

  static List<PatchUserDto>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PatchUserDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PatchUserDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PatchUserDto> mapFromJson(dynamic json) {
    final map = <String, PatchUserDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PatchUserDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PatchUserDto-objects as value to a dart map
  static Map<String, List<PatchUserDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PatchUserDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PatchUserDto.listFromJson(
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
  static const requiredKeys = <String>{};
}

class PatchUserDtoRoleEnum {
  /// Instantiate a new enum with the provided [value].
  const PatchUserDtoRoleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const USER = PatchUserDtoRoleEnum._(r'USER');
  static const OWNER = PatchUserDtoRoleEnum._(r'OWNER');
  static const ADMIN = PatchUserDtoRoleEnum._(r'ADMIN');
  static const SUPERADMIN = PatchUserDtoRoleEnum._(r'SUPERADMIN');

  /// List of all possible values in this [enum][PatchUserDtoRoleEnum].
  static const values = <PatchUserDtoRoleEnum>[
    USER,
    OWNER,
    ADMIN,
    SUPERADMIN,
  ];

  static PatchUserDtoRoleEnum? fromJson(dynamic value) =>
      PatchUserDtoRoleEnumTypeTransformer().decode(value);

  static List<PatchUserDtoRoleEnum>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PatchUserDtoRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PatchUserDtoRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PatchUserDtoRoleEnum] to String,
/// and [decode] dynamic data back to [PatchUserDtoRoleEnum].
class PatchUserDtoRoleEnumTypeTransformer {
  factory PatchUserDtoRoleEnumTypeTransformer() =>
      _instance ??= const PatchUserDtoRoleEnumTypeTransformer._();

  const PatchUserDtoRoleEnumTypeTransformer._();

  String encode(PatchUserDtoRoleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a PatchUserDtoRoleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PatchUserDtoRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'USER':
          return PatchUserDtoRoleEnum.USER;
        case r'OWNER':
          return PatchUserDtoRoleEnum.OWNER;
        case r'ADMIN':
          return PatchUserDtoRoleEnum.ADMIN;
        case r'SUPERADMIN':
          return PatchUserDtoRoleEnum.SUPERADMIN;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [PatchUserDtoRoleEnumTypeTransformer] instance.
  static PatchUserDtoRoleEnumTypeTransformer? _instance;
}

class PatchUserDtoStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const PatchUserDtoStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ACTIVE = PatchUserDtoStatusEnum._(r'ACTIVE');
  static const INACTIVE = PatchUserDtoStatusEnum._(r'INACTIVE');

  /// List of all possible values in this [enum][PatchUserDtoStatusEnum].
  static const values = <PatchUserDtoStatusEnum>[
    ACTIVE,
    INACTIVE,
  ];

  static PatchUserDtoStatusEnum? fromJson(dynamic value) =>
      PatchUserDtoStatusEnumTypeTransformer().decode(value);

  static List<PatchUserDtoStatusEnum>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PatchUserDtoStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PatchUserDtoStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PatchUserDtoStatusEnum] to String,
/// and [decode] dynamic data back to [PatchUserDtoStatusEnum].
class PatchUserDtoStatusEnumTypeTransformer {
  factory PatchUserDtoStatusEnumTypeTransformer() =>
      _instance ??= const PatchUserDtoStatusEnumTypeTransformer._();

  const PatchUserDtoStatusEnumTypeTransformer._();

  String encode(PatchUserDtoStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a PatchUserDtoStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PatchUserDtoStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ACTIVE':
          return PatchUserDtoStatusEnum.ACTIVE;
        case r'INACTIVE':
          return PatchUserDtoStatusEnum.INACTIVE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [PatchUserDtoStatusEnumTypeTransformer] instance.
  static PatchUserDtoStatusEnumTypeTransformer? _instance;
}
