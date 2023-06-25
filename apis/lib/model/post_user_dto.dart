//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostUserDto {
  /// Returns a new [PostUserDto] instance.
  PostUserDto({
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profile,
  });

  String email;

  String firstName;

  String lastName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PatchUserProfileDto? profile;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostUserDto &&
     other.email == email &&
     other.firstName == firstName &&
     other.lastName == lastName &&
     other.profile == profile;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (email.hashCode) +
    (firstName.hashCode) +
    (lastName.hashCode) +
    (profile == null ? 0 : profile!.hashCode);

  @override
  String toString() => 'PostUserDto[email=$email, firstName=$firstName, lastName=$lastName, profile=$profile]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'email'] = this.email;
      json[r'firstName'] = this.firstName;
      json[r'lastName'] = this.lastName;
    if (this.profile != null) {
      json[r'profile'] = this.profile;
    } else {
      json[r'profile'] = null;
    }
    return json;
  }

  /// Returns a new [PostUserDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostUserDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostUserDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostUserDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostUserDto(
        email: mapValueOfType<String>(json, r'email')!,
        firstName: mapValueOfType<String>(json, r'firstName')!,
        lastName: mapValueOfType<String>(json, r'lastName')!,
        profile: PatchUserProfileDto.fromJson(json[r'profile']),
      );
    }
    return null;
  }

  static List<PostUserDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostUserDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostUserDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostUserDto> mapFromJson(dynamic json) {
    final map = <String, PostUserDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostUserDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostUserDto-objects as value to a dart map
  static Map<String, List<PostUserDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostUserDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostUserDto.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'email',
    'firstName',
    'lastName',
  };
}

