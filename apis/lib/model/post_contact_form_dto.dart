//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostContactFormDto {
  /// Returns a new [PostContactFormDto] instance.
  PostContactFormDto({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.message,
    this.honeypot,
  });

  String fullName;

  String email;

  String phoneNumber;

  String city;

  String message;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? honeypot;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostContactFormDto &&
          other.fullName == fullName &&
          other.email == email &&
          other.phoneNumber == phoneNumber &&
          other.city == city &&
          other.message == message &&
          other.honeypot == honeypot;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (fullName.hashCode) +
      (email.hashCode) +
      (phoneNumber.hashCode) +
      (city.hashCode) +
      (message.hashCode) +
      (honeypot == null ? 0 : honeypot!.hashCode);

  @override
  String toString() =>
      'PostContactFormDto[fullName=$fullName, email=$email, phoneNumber=$phoneNumber, city=$city, message=$message, honeypot=$honeypot]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'fullName'] = this.fullName;
    json[r'email'] = this.email;
    json[r'phoneNumber'] = this.phoneNumber;
    json[r'city'] = this.city;
    json[r'message'] = this.message;
    if (this.honeypot != null) {
      json[r'honeypot'] = this.honeypot;
    } else {
      json[r'honeypot'] = null;
    }
    return json;
  }

  /// Returns a new [PostContactFormDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostContactFormDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "PostContactFormDto[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "PostContactFormDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostContactFormDto(
        fullName: mapValueOfType<String>(json, r'fullName')!,
        email: mapValueOfType<String>(json, r'email')!,
        phoneNumber: mapValueOfType<String>(json, r'phoneNumber')!,
        city: mapValueOfType<String>(json, r'city')!,
        message: mapValueOfType<String>(json, r'message')!,
        honeypot: mapValueOfType<String>(json, r'honeypot'),
      );
    }
    return null;
  }

  static List<PostContactFormDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PostContactFormDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostContactFormDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostContactFormDto> mapFromJson(dynamic json) {
    final map = <String, PostContactFormDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostContactFormDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostContactFormDto-objects as value to a dart map
  static Map<String, List<PostContactFormDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PostContactFormDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostContactFormDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'fullName',
    'email',
    'phoneNumber',
    'city',
    'message',
  };
}
