//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicUserProfile {
  /// Returns a new [PublicUserProfile] instance.
  PublicUserProfile({
    required this.displayName,
    required this.banner,
    required this.title,
    required this.company,
    required this.birthday,
    required this.address,
    required this.notes,
    this.emails = const [],
    this.phoneNumbers = const [],
    this.links = const [],
  });

  String? displayName;

  String? banner;

  String? title;

  String? company;

  DateTime? birthday;

  String? address;

  String? notes;

  List<Email> emails;

  List<PhoneNumber> phoneNumbers;

  List<Link> links;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicUserProfile &&
          other.displayName == displayName &&
          other.banner == banner &&
          other.title == title &&
          other.company == company &&
          other.birthday == birthday &&
          other.address == address &&
          other.notes == notes &&
          other.emails == emails &&
          other.phoneNumbers == phoneNumbers &&
          other.links == links;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (displayName == null ? 0 : displayName!.hashCode) +
      (banner == null ? 0 : banner!.hashCode) +
      (title == null ? 0 : title!.hashCode) +
      (company == null ? 0 : company!.hashCode) +
      (birthday == null ? 0 : birthday!.hashCode) +
      (address == null ? 0 : address!.hashCode) +
      (notes == null ? 0 : notes!.hashCode) +
      (emails.hashCode) +
      (phoneNumbers.hashCode) +
      (links.hashCode);

  @override
  String toString() =>
      'PublicUserProfile[displayName=$displayName, banner=$banner, title=$title, company=$company, birthday=$birthday, address=$address, notes=$notes, emails=$emails, phoneNumbers=$phoneNumbers, links=$links]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.displayName != null) {
      json[r'displayName'] = this.displayName;
    } else {
      json[r'displayName'] = null;
    }
    if (this.banner != null) {
      json[r'banner'] = this.banner;
    } else {
      json[r'banner'] = null;
    }
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.company != null) {
      json[r'company'] = this.company;
    } else {
      json[r'company'] = null;
    }
    if (this.birthday != null) {
      json[r'birthday'] = this.birthday!.toUtc().toIso8601String();
    } else {
      json[r'birthday'] = null;
    }
    if (this.address != null) {
      json[r'address'] = this.address;
    } else {
      json[r'address'] = null;
    }
    if (this.notes != null) {
      json[r'notes'] = this.notes;
    } else {
      json[r'notes'] = null;
    }
    json[r'emails'] = this.emails;
    json[r'phoneNumbers'] = this.phoneNumbers;
    json[r'links'] = this.links;
    return json;
  }

  /// Returns a new [PublicUserProfile] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicUserProfile? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "PublicUserProfile[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "PublicUserProfile[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PublicUserProfile(
        displayName: mapValueOfType<String>(json, r'displayName'),
        banner: mapValueOfType<String>(json, r'banner'),
        title: mapValueOfType<String>(json, r'title'),
        company: mapValueOfType<String>(json, r'company'),
        birthday: mapDateTime(json, r'birthday', ''),
        address: mapValueOfType<String>(json, r'address'),
        notes: mapValueOfType<String>(json, r'notes'),
        emails: Email.listFromJson(json[r'emails']),
        phoneNumbers: PhoneNumber.listFromJson(json[r'phoneNumbers']),
        links: Link.listFromJson(json[r'links']),
      );
    }
    return null;
  }

  static List<PublicUserProfile> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PublicUserProfile>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicUserProfile.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicUserProfile> mapFromJson(dynamic json) {
    final map = <String, PublicUserProfile>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicUserProfile.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicUserProfile-objects as value to a dart map
  static Map<String, List<PublicUserProfile>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PublicUserProfile>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PublicUserProfile.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'displayName',
    'banner',
    'title',
    'company',
    'birthday',
    'address',
    'notes',
    'emails',
    'phoneNumbers',
    'links',
  };
}
