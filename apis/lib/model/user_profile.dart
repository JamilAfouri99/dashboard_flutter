//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserProfile {
  /// Returns a new [UserProfile] instance.
  UserProfile({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.displayName,
    required this.birthday,
    this.banner,
    this.title,
    this.company,
    this.address,
    this.notes,
    this.emails = const [],
    this.phoneNumbers = const [],
    this.links = const [],
  });

  String id;

  DateTime createdAt;

  DateTime updatedAt;

  String userId;

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
      other is UserProfile &&
          other.id == id &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.userId == userId &&
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
      (id.hashCode) +
      (createdAt.hashCode) +
      (updatedAt.hashCode) +
      (userId.hashCode) +
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
      'UserProfile[id=$id, createdAt=$createdAt, updatedAt=$updatedAt, userId=$userId, displayName=$displayName, banner=$banner, title=$title, company=$company, birthday=$birthday, address=$address, notes=$notes, emails=$emails, phoneNumbers=$phoneNumbers, links=$links]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = this.id;
    json[r'createdAt'] = this.createdAt.toUtc().toIso8601String();
    json[r'updatedAt'] = this.updatedAt.toUtc().toIso8601String();
    json[r'userId'] = this.userId;
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

  /// Returns a new [UserProfile] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserProfile? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserProfile[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserProfile[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserProfile(
        id: mapValueOfType<String>(json, r'id')!,
        createdAt: mapDateTime(json, r'createdAt', '')!,
        updatedAt: mapDateTime(json, r'updatedAt', '')!,
        userId: mapValueOfType<String>(json, r'userId')!,
        displayName: mapValueOfType<String>(json, r'displayName'),
        banner: json[r'banner'] == null ? null : mapValueOfType<String>(json, r'banner'),
        title: json[r'title'] == null ? null : mapValueOfType<String>(json, r'title'),
        company: json[r'company'] == null ? null : mapValueOfType<String>(json, r'company'),
        birthday: mapDateTime(json, r'birthday', ''),
        address: json[r'address'] == null ? null : mapValueOfType<String>(json, r'address'),
        notes: json[r'notes'] == null ? null : mapValueOfType<String>(json, r'notes'),
        emails: Email.listFromJson(json[r'emails']),
        phoneNumbers: PhoneNumber.listFromJson(json[r'phoneNumbers']),
        links: json[r'links'].length == 0 ? [] : Link.listFromJson(json[r'links']),
      );
    }
    return null;
  }

  static List<UserProfile> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <UserProfile>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserProfile.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserProfile> mapFromJson(dynamic json) {
    final map = <String, UserProfile>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserProfile.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserProfile-objects as value to a dart map
  static Map<String, List<UserProfile>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<UserProfile>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserProfile.listFromJson(
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
    'userId',
    'displayName',
    'birthday',
    'emails',
    'phoneNumbers',
    'links',
  };
}
