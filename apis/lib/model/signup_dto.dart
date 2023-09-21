//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SignupDto {
  /// Returns a new [SignupDto] instance.
  SignupDto({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  String email;

  String password;

  String firstName;

  String lastName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignupDto &&
          other.email == email &&
          other.password == password &&
          other.firstName == firstName &&
          other.lastName == lastName;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (email.hashCode) +
      (password.hashCode) +
      (firstName.hashCode) +
      (lastName.hashCode);

  @override
  String toString() =>
      'SignupDto[email=$email, password=$password, firstName=$firstName, lastName=$lastName]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'email'] = this.email;
    json[r'password'] = this.password;
    json[r'firstName'] = this.firstName;
    json[r'lastName'] = this.lastName;
    return json;
  }

  /// Returns a new [SignupDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SignupDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "SignupDto[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "SignupDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SignupDto(
        email: mapValueOfType<String>(json, r'email')!,
        password: mapValueOfType<String>(json, r'password')!,
        firstName: mapValueOfType<String>(json, r'firstName')!,
        lastName: mapValueOfType<String>(json, r'lastName')!,
      );
    }
    return null;
  }

  static List<SignupDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <SignupDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignupDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SignupDto> mapFromJson(dynamic json) {
    final map = <String, SignupDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SignupDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SignupDto-objects as value to a dart map
  static Map<String, List<SignupDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<SignupDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SignupDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'email',
    'password',
    'firstName',
    'lastName',
  };
}
