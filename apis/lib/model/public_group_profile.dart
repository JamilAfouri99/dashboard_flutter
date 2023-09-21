//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicGroupProfile {
  /// Returns a new [PublicGroupProfile] instance.
  PublicGroupProfile({
    required this.banner,
  });

  String? banner;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicGroupProfile && other.banner == banner;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (banner == null ? 0 : banner!.hashCode);

  @override
  String toString() => 'PublicGroupProfile[banner=$banner]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.banner != null) {
      json[r'banner'] = this.banner;
    } else {
      json[r'banner'] = null;
    }
    return json;
  }

  /// Returns a new [PublicGroupProfile] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicGroupProfile? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "PublicGroupProfile[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "PublicGroupProfile[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PublicGroupProfile(
        banner: mapValueOfType<String>(json, r'banner'),
      );
    }
    return null;
  }

  static List<PublicGroupProfile> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PublicGroupProfile>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicGroupProfile.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicGroupProfile> mapFromJson(dynamic json) {
    final map = <String, PublicGroupProfile>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicGroupProfile.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicGroupProfile-objects as value to a dart map
  static Map<String, List<PublicGroupProfile>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PublicGroupProfile>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PublicGroupProfile.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'banner',
  };
}
