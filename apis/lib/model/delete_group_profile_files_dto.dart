//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DeleteGroupProfileFilesDto {
  /// Returns a new [DeleteGroupProfileFilesDto] instance.
  DeleteGroupProfileFilesDto({
    required this.banner,
  });

  bool banner;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DeleteGroupProfileFilesDto &&
     other.banner == banner;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (banner.hashCode);

  @override
  String toString() => 'DeleteGroupProfileFilesDto[banner=$banner]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'banner'] = this.banner;
    return json;
  }

  /// Returns a new [DeleteGroupProfileFilesDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DeleteGroupProfileFilesDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DeleteGroupProfileFilesDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DeleteGroupProfileFilesDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DeleteGroupProfileFilesDto(
        banner: mapValueOfType<bool>(json, r'banner')!,
      );
    }
    return null;
  }

  static List<DeleteGroupProfileFilesDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeleteGroupProfileFilesDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeleteGroupProfileFilesDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DeleteGroupProfileFilesDto> mapFromJson(dynamic json) {
    final map = <String, DeleteGroupProfileFilesDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeleteGroupProfileFilesDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DeleteGroupProfileFilesDto-objects as value to a dart map
  static Map<String, List<DeleteGroupProfileFilesDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DeleteGroupProfileFilesDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeleteGroupProfileFilesDto.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'banner',
  };
}

