//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PatchGroupDto {
  /// Returns a new [PatchGroupDto] instance.
  PatchGroupDto({
    this.name,
  });

  String? name;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PatchGroupDto &&
     other.name == name;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode);

  @override
  String toString() => 'PatchGroupDto[name=$name]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    return json;
  }

  /// Returns a new [PatchGroupDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PatchGroupDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PatchGroupDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PatchGroupDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PatchGroupDto(
        name: mapValueOfType<String>(json, r'name'),
      );
    }
    return null;
  }

  static List<PatchGroupDto>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PatchGroupDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PatchGroupDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PatchGroupDto> mapFromJson(dynamic json) {
    final map = <String, PatchGroupDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PatchGroupDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PatchGroupDto-objects as value to a dart map
  static Map<String, List<PatchGroupDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PatchGroupDto>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PatchGroupDto.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

