//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PaginationMetaData {
  /// Returns a new [PaginationMetaData] instance.
  PaginationMetaData({
    required this.total,
    required this.lastPage,
    required this.currentPage,
    required this.perPage,
    this.prev,
    this.next,
  });

  num total;

  num lastPage;

  num currentPage;

  num perPage;

  num? prev;

  num? next;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaginationMetaData &&
          other.total == total &&
          other.lastPage == lastPage &&
          other.currentPage == currentPage &&
          other.perPage == perPage &&
          other.prev == prev &&
          other.next == next;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (total.hashCode) +
      (lastPage.hashCode) +
      (currentPage.hashCode) +
      (perPage.hashCode) +
      (prev == null ? 0 : prev!.hashCode) +
      (next == null ? 0 : next!.hashCode);

  @override
  String toString() =>
      'PaginationMetaData[total=$total, lastPage=$lastPage, currentPage=$currentPage, perPage=$perPage, prev=$prev, next=$next]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'total'] = this.total;
    json[r'lastPage'] = this.lastPage;
    json[r'currentPage'] = this.currentPage;
    json[r'perPage'] = this.perPage;
    if (this.prev != null) {
      json[r'prev'] = this.prev;
    } else {
      json[r'prev'] = null;
    }
    if (this.next != null) {
      json[r'next'] = this.next;
    } else {
      json[r'next'] = null;
    }
    return json;
  }

  /// Returns a new [PaginationMetaData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PaginationMetaData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "PaginationMetaData[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "PaginationMetaData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PaginationMetaData(
        total: num.parse(json[r'total'].toString()),
        lastPage: num.parse(json[r'lastPage'].toString()),
        currentPage: num.parse(json[r'currentPage'].toString()),
        perPage: num.parse(json[r'perPage'].toString()),
        prev: json[r'prev'] == null ? null : num.parse(json[r'prev'].toString()),
        next: json[r'next'] == null ? null : num.parse(json[r'next'].toString()),
      );
    }
    return null;
  }

  static List<PaginationMetaData> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PaginationMetaData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PaginationMetaData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PaginationMetaData> mapFromJson(dynamic json) {
    final map = <String, PaginationMetaData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PaginationMetaData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PaginationMetaData-objects as value to a dart map
  static Map<String, List<PaginationMetaData>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PaginationMetaData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PaginationMetaData.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'total',
    'lastPage',
    'currentPage',
    'perPage',
  };
}
