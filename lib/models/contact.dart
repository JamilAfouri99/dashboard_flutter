import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  static const String idProperty = 'id';
  static const String nameProperty = 'name';
  static const String positionProperty = 'position';
  static const String imageProperty = 'image';
  static const String categoriesProperty = 'categories';
  static const String titleProperty = 'title';
  static const String companyProperty = 'company';
  static const String emailsProperty = 'emails';
  static const String phonesProperty = 'phones';
  static const String addressProperty = 'address';
  static const String birthdayProperty = 'birthday';
  static const String noteProperty = 'note';

  final String id;
  final String name;
  final String position;
  final String image;
  final List<String> categories;
  final String title;
  final String company;
  final List<Email> emails;
  final List<Phone> phones;
  final String address;
  final DateTime birthday;
  final String note;

  const Contact({
    required this.id,
    required this.name,
    required this.position,
    required this.image,
    required this.categories,
    required this.title,
    required this.company,
    required this.emails,
    required this.phones,
    required this.address,
    required this.birthday,
    required this.note,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json[idProperty],
        name: json[nameProperty],
        position: json[positionProperty],
        image: json[imageProperty],
        categories: json[categoriesProperty],
        title: json[titleProperty],
        company: json[companyProperty],
        emails: json[emailsProperty].map<Email>((email) => Email.fromJson(email)),
        phones: json[phonesProperty].map<Phone>((phone) => Phone.fromJson(phone)),
        address: json[addressProperty],
        birthday: json[birthdayProperty],
        note: json[noteProperty],
      );

  Map<String, dynamic> toJson() => {
        idProperty: id,
        nameProperty: name,
        positionProperty: position,
        imageProperty: image,
        categoriesProperty: categories,
        titleProperty: title,
        companyProperty: company,
        emailsProperty: emails,
        phonesProperty: phones,
        addressProperty: address,
        birthdayProperty: birthday,
        noteProperty: note,
      };

  Contact copyWith({
    String? id,
    String? name,
    String? position,
    String? image,
    List<String>? categories,
    String? title,
    String? company,
    List<Email>? emails,
    List<Phone>? phones,
    String? address,
    DateTime? birthday,
    String? note,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      image: image ?? this.image,
      categories: categories ?? this.categories,
      title: title ?? this.title,
      company: company ?? this.company,
      emails: emails ?? this.emails,
      phones: phones ?? this.phones,
      address: address ?? this.address,
      birthday: birthday ?? this.birthday,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        position,
        image,
        categories,
        title,
        company,
        emails,
        phones,
        address,
        birthday,
        note,
      ];
}

class Email extends Equatable {
  static const String idProperty = 'id';
  static const String emailProperty = 'email';
  static const String labelProperty = 'label';

  final String id;
  final String email;
  final String label;

  const Email({
    required this.id,
    required this.email,
    required this.label,
  });

  factory Email.fromJson(Map<String, dynamic> json) => Email(
        id: json[idProperty],
        email: json[emailProperty],
        label: json[labelProperty],
      );

  Map<String, dynamic> toJson() => {
        emailProperty: email,
        labelProperty: label,
        idProperty: id,
      };

  Email copyWith({
    String? id,
    String? email,
    String? label,
  }) {
    return Email(
      id: id ?? this.id,
      email: email ?? this.email,
      label: label ?? this.label,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        label,
      ];
}

class Phone extends Equatable {
  static const String idProperty = 'id';
  static const String phoneProperty = 'phone';
  static const String labelProperty = 'label';

  final String id;
  final String phone;
  final String label;

  const Phone({
    required this.id,
    required this.phone,
    required this.label,
  });

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        id: json[idProperty],
        phone: json[phoneProperty],
        label: json[labelProperty],
      );

  Map<String, dynamic> toJson() => {
        idProperty: id,
        phoneProperty: phone,
        labelProperty: label,
      };

  Phone copyWith({
    String? id,
    String? phone,
    String? label,
  }) {
    return Phone(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      label: label ?? this.label,
    );
  }

  @override
  List<Object?> get props => [
        id,
        phone,
        label,
      ];
}
