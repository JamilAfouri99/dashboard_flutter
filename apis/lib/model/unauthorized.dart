//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Unauthorized {
  /// Returns a new [Unauthorized] instance.
  Unauthorized({
    required this.statusCode,
    required this.message,
  });

  num statusCode;

  String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Unauthorized &&
          other.statusCode == statusCode &&
          other.message == message;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (statusCode.hashCode) + (message.hashCode);

  @override
  String toString() => 'Unauthorized[statusCode=$statusCode, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'statusCode'] = this.statusCode;
    json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [Unauthorized] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Unauthorized? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "Unauthorized[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "Unauthorized[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Unauthorized(
        statusCode: num.parse('${json[r'statusCode']}'),
        message: mapValueOfType<String>(json, r'message')!,
      );
    }
    return null;
  }

  static List<Unauthorized> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <Unauthorized>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Unauthorized.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Unauthorized> mapFromJson(dynamic json) {
    final map = <String, Unauthorized>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Unauthorized.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Unauthorized-objects as value to a dart map
  static Map<String, List<Unauthorized>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<Unauthorized>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Unauthorized.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'statusCode',
    'message',
  };
}
