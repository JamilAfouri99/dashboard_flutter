//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DeleteUserFilesDto {
  /// Returns a new [DeleteUserFilesDto] instance.
  DeleteUserFilesDto({
    required this.avatar,
  });

  bool avatar;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DeleteUserFilesDto &&
     other.avatar == avatar;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (avatar.hashCode);

  @override
  String toString() => 'DeleteUserFilesDto[avatar=$avatar]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'avatar'] = this.avatar;
    return json;
  }

  /// Returns a new [DeleteUserFilesDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DeleteUserFilesDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DeleteUserFilesDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DeleteUserFilesDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DeleteUserFilesDto(
        avatar: mapValueOfType<bool>(json, r'avatar')!,
      );
    }
    return null;
  }

  static List<DeleteUserFilesDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeleteUserFilesDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeleteUserFilesDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DeleteUserFilesDto> mapFromJson(dynamic json) {
    final map = <String, DeleteUserFilesDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeleteUserFilesDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DeleteUserFilesDto-objects as value to a dart map
  static Map<String, List<DeleteUserFilesDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DeleteUserFilesDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeleteUserFilesDto.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'avatar',
  };
}

