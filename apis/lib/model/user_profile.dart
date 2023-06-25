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
    required this.banner,
    required this.title,
    required this.company,
    required this.birthday,
    required this.address,
    required this.notes,
    this.emails = const [],
    this.phoneNumbers = const [],
  });

  num id;

  DateTime createdAt;

  DateTime updatedAt;

  num userId;

  String displayName;

  String banner;

  String title;

  String company;

  DateTime birthday;

  String address;

  String notes;

  List<Email> emails;

  List<PhoneNumber> phoneNumbers;

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
          other.phoneNumbers == phoneNumbers;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id.hashCode) +
      (createdAt.hashCode) +
      (updatedAt.hashCode) +
      (userId.hashCode) +
      (displayName.hashCode) +
      (banner.hashCode) +
      (title.hashCode) +
      (company.hashCode) +
      (birthday.hashCode) +
      (address.hashCode) +
      (notes.hashCode) +
      (emails.hashCode) +
      (phoneNumbers.hashCode);

  @override
  String toString() =>
      'UserProfile[id=$id, createdAt=$createdAt, updatedAt=$updatedAt, userId=$userId, displayName=$displayName, banner=$banner, title=$title, company=$company, birthday=$birthday, address=$address, notes=$notes, emails=$emails, phoneNumbers=$phoneNumbers]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = this.id;
    json[r'createdAt'] = this.createdAt.toUtc().toIso8601String();
    json[r'updatedAt'] = this.updatedAt.toUtc().toIso8601String();
    json[r'userId'] = this.userId;
    json[r'displayName'] = this.displayName;
    json[r'banner'] = this.banner;
    json[r'title'] = this.title;
    json[r'company'] = this.company;
    json[r'birthday'] = this.birthday.toUtc().toIso8601String();
    json[r'address'] = this.address;
    json[r'notes'] = this.notes;
    json[r'emails'] = this.emails;
    json[r'phoneNumbers'] = this.phoneNumbers;
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
        id: num.parse(json[r'id'].toString()),
        createdAt: mapDateTime(json, r'createdAt', '')!,
        updatedAt: mapDateTime(json, r'updatedAt', '')!,
        userId: num.parse(json[r'userId'].toString()),
        displayName: mapValueOfType<String>(json, r'displayName')!,
        banner: mapValueOfType<String>(json, r'banner')!,
        title: mapValueOfType<String>(json, r'title')!,
        company: mapValueOfType<String>(json, r'company')!,
        birthday: mapDateTime(json, r'birthday', '')!,
        address: mapValueOfType<String>(json, r'address')!,
        notes: mapValueOfType<String>(json, r'notes')!,
        emails: Email.listFromJson(json[r'emails'])!,
        phoneNumbers: PhoneNumber.listFromJson(json[r'phoneNumbers'])!,
      );
    }
    return null;
  }

  static List<UserProfile>? listFromJson(
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
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserProfile.listFromJson(
          entry.value,
          growable: growable,
        );
        if (value != null) {
          map[entry.key] = value;
        }
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
    'banner',
    'title',
    'company',
    'birthday',
    'address',
    'notes',
    'emails',
    'phoneNumbers',
  };
}
