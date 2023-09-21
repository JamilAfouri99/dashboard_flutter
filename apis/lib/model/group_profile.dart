//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GroupProfile {
  /// Returns a new [GroupProfile] instance.
  GroupProfile({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.groupId,
    required this.banner,
  });

  String id;

  DateTime createdAt;

  DateTime updatedAt;

  String groupId;

  String? banner;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupProfile &&
          other.id == id &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.groupId == groupId &&
          other.banner == banner;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id.hashCode) +
      (createdAt.hashCode) +
      (updatedAt.hashCode) +
      (groupId.hashCode) +
      (banner == null ? 0 : banner!.hashCode);

  @override
  String toString() =>
      'GroupProfile[id=$id, createdAt=$createdAt, updatedAt=$updatedAt, groupId=$groupId, banner=$banner]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = this.id;
    json[r'createdAt'] = this.createdAt.toUtc().toIso8601String();
    json[r'updatedAt'] = this.updatedAt.toUtc().toIso8601String();
    json[r'groupId'] = this.groupId;
    if (this.banner != null) {
      json[r'banner'] = this.banner;
    } else {
      json[r'banner'] = null;
    }
    return json;
  }

  /// Returns a new [GroupProfile] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GroupProfile? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "GroupProfile[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "GroupProfile[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GroupProfile(
        id: mapValueOfType<String>(json, r'id')!,
        createdAt: mapDateTime(json, r'createdAt', '')!,
        updatedAt: mapDateTime(json, r'updatedAt', '')!,
        groupId: mapValueOfType<String>(json, r'groupId')!,
        banner: mapValueOfType<String>(json, r'banner'),
      );
    }
    return null;
  }

  static List<GroupProfile> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <GroupProfile>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GroupProfile.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GroupProfile> mapFromJson(dynamic json) {
    final map = <String, GroupProfile>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GroupProfile.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GroupProfile-objects as value to a dart map
  static Map<String, List<GroupProfile>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<GroupProfile>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GroupProfile.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'createdAt',
    'updatedAt',
    'groupId',
    'banner',
  };
}
