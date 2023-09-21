//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Link {
  /// Returns a new [Link] instance.
  Link({
    required this.link,
    required this.label,
  });

  String link;

  LinkLabelEnum label;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Link && other.link == link && other.label == label;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (link.hashCode) + (label.hashCode);

  @override
  String toString() => 'Link[link=$link, label=$label]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'link'] = this.link;
    json[r'label'] = this.label;
    return json;
  }

  /// Returns a new [Link] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Link? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Link[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Link[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Link(
        link: mapValueOfType<String>(json, r'link')!,
        label: LinkLabelEnum.fromJson(json[r'label'])!,
      );
    }
    return null;
  }

  static List<Link> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <Link>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Link.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Link> mapFromJson(dynamic json) {
    final map = <String, Link>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Link.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Link-objects as value to a dart map
  static Map<String, List<Link>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<Link>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Link.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'link',
    'label',
  };
}

class LinkLabelEnum {
  /// Instantiate a new enum with the provided [value].
  const LinkLabelEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const facebook = LinkLabelEnum._(r'Facebook');
  static const gitHub = LinkLabelEnum._(r'GitHub');
  static const gmail = LinkLabelEnum._(r'Gmail');
  static const instagram = LinkLabelEnum._(r'Instagram');
  static const link = LinkLabelEnum._(r'Link');
  static const linkedIn = LinkLabelEnum._(r'LinkedIn');
  static const outLook = LinkLabelEnum._(r'OutLook');
  static const qCarder = LinkLabelEnum._(r'QCarder');
  static const skype = LinkLabelEnum._(r'Skype');
  static const slack = LinkLabelEnum._(r'Slack');
  static const whatsApp = LinkLabelEnum._(r'WhatsApp');
  static const X = LinkLabelEnum._(r'X');

  /// List of all possible values in this [enum][LinkLabelEnum].
  static const values = <LinkLabelEnum>[
    facebook,
    gitHub,
    gmail,
    instagram,
    link,
    linkedIn,
    outLook,
    qCarder,
    skype,
    slack,
    whatsApp,
    X,
  ];

  static LinkLabelEnum? fromJson(dynamic value) => LinkLabelEnumTypeTransformer().decode(value);

  static List<LinkLabelEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <LinkLabelEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LinkLabelEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [LinkLabelEnum] to String,
/// and [decode] dynamic data back to [LinkLabelEnum].
class LinkLabelEnumTypeTransformer {
  factory LinkLabelEnumTypeTransformer() => _instance ??= const LinkLabelEnumTypeTransformer._();

  const LinkLabelEnumTypeTransformer._();

  String encode(LinkLabelEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a LinkLabelEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  LinkLabelEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch ((data as String).toLowerCase()) {
        case r'facebook':
          return LinkLabelEnum.facebook;
        case r'github':
          return LinkLabelEnum.gitHub;
        case r'gmail':
          return LinkLabelEnum.gmail;
        case r'instagram':
          return LinkLabelEnum.instagram;
        case r'link':
          return LinkLabelEnum.link;
        case r'linkedin':
          return LinkLabelEnum.linkedIn;
        case r'outlook':
          return LinkLabelEnum.outLook;
        case r'qcarder':
          return LinkLabelEnum.qCarder;
        case r'skype':
          return LinkLabelEnum.skype;
        case r'slack':
          return LinkLabelEnum.slack;
        case r'whatsapp':
          return LinkLabelEnum.whatsApp;
        case r'x':
          return LinkLabelEnum.X;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [LinkLabelEnumTypeTransformer] instance.
  static LinkLabelEnumTypeTransformer? _instance;
}
