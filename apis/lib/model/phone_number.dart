//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PhoneNumber {
  /// Returns a new [PhoneNumber] instance.
  PhoneNumber({
    required this.phoneNumber,
    required this.country,
    required this.label,
  });

  String phoneNumber;

  String country;

  String label;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneNumber &&
          other.phoneNumber == phoneNumber &&
          other.country == country &&
          other.label == label;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (phoneNumber.hashCode) + (country.hashCode) + (label.hashCode);

  @override
  String toString() =>
      'PhoneNumber[phoneNumber=$phoneNumber, country=$country, label=$label]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'phoneNumber'] = this.phoneNumber;
    json[r'country'] = this.country;
    json[r'label'] = this.label;
    return json;
  }

  /// Returns a new [PhoneNumber] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PhoneNumber? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "PhoneNumber[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "PhoneNumber[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PhoneNumber(
        phoneNumber: mapValueOfType<String>(json, r'phoneNumber')!,
        country: mapValueOfType<String>(json, r'country')!,
        label: mapValueOfType<String>(json, r'label')!,
      );
    }
    return null;
  }

  static List<PhoneNumber> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PhoneNumber>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PhoneNumber.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PhoneNumber> mapFromJson(dynamic json) {
    final map = <String, PhoneNumber>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PhoneNumber.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PhoneNumber-objects as value to a dart map
  static Map<String, List<PhoneNumber>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PhoneNumber>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PhoneNumber.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'phoneNumber',
    'country',
    'label',
  };
}
