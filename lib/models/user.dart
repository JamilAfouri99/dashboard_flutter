import 'package:dashboard/helpers/date_time.dart';
import 'package:equatable/equatable.dart';

class UsersResponse {
  static const usersProperty = 'data';
  static const paginationProperty = 'meta';

  List<User>? users;
  Pagination? pagination;

  UsersResponse({this.users, this.pagination});

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        users: json[usersProperty] != null
            ? List.generate(
                json[usersProperty].length,
                (i) => User.fromJson(json[usersProperty][i]),
              )
            : null,
        pagination: json[paginationProperty] != null
            ? Pagination.fromJson(
                json[paginationProperty],
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
        usersProperty: users,
        paginationProperty: pagination,
      };
}

class User {
  static const idProperty = 'id';
  static const createdAtProperty = 'createdAt';
  static const updatedAtProperty = 'updatedAt';
  static const emailProperty = 'email';
  static const firstNameProperty = 'firstName';
  static const lastNameProperty = 'lastName';
  static const avatarProperty = 'avatar';
  static const roleProperty = 'role';
  static const statusProperty = 'status';
  static const groupIdProperty = 'groupId';
  static const groupProperty = 'group';
  static const profileProperty = 'profile';

  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;
  String? role;
  String? status;
  int? groupId;
  Group? group;
  Profile? profile;

  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.role,
    this.status,
    this.groupId,
    this.group,
    this.profile,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json[idProperty];
    createdAt = json[createdAtProperty] != null
        ? DateTime.parse(json[createdAtProperty])
        : json[createdAtProperty];
    updatedAt = json[updatedAtProperty] != null
        ? DateTime.parse(json[updatedAtProperty])
        : json[updatedAtProperty];
    email = json[emailProperty];
    firstName = json[firstNameProperty];
    lastName = json[lastNameProperty];
    avatar = json[avatarProperty];
    role = json[roleProperty];
    status = json[statusProperty];
    groupId = json[groupIdProperty];
    group = json[groupProperty] != null ? Group.fromJson(json[groupProperty]) : null;
    profile = json[profileProperty] != null ? Profile.fromJson(json[profileProperty]) : null;
  }

  Map<String, dynamic> toJson() => {
        firstNameProperty: firstName,
        lastNameProperty: lastName,
        avatarProperty: avatar,
        emailProperty: email,
        // roleProperty: role,
        statusProperty: status,
        groupIdProperty: groupId,
        groupProperty: group != null ? group!.toJson() : null,
        profileProperty: profile != null ? profile!.toJson() : null,
      };
}

class Group {
  static const idProperty = 'id';
  static const createdAtProperty = 'createdAt';
  static const updatedAtProperty = 'updatedAt';
  static const nameProperty = 'name';

  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;

  Group({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  Group.fromJson(Map<String, dynamic> json) {
    id = json[idProperty];
    createdAt = json[createdAtProperty] != null
        ? DateTime.parse(json[createdAtProperty])
        : json[createdAtProperty];
    updatedAt = json[updatedAtProperty] != null
        ? DateTime.parse(json[updatedAtProperty])
        : json[updatedAtProperty];
    name = json[nameProperty];
  }

  Map<String, dynamic> toJson() => {
        nameProperty: name,
      };
}

class Profile {
  static const idProperty = 'id';
  static const createdAtProperty = 'createdAt';
  static const updatedAtProperty = 'updatedAt';
  static const bannerProperty = 'banner';
  static const titleProperty = 'title';
  static const companyProperty = 'company';
  static const birthdayProperty = 'birthday';
  static const addressProperty = 'address';
  static const notesProperty = 'notes';
  static const userIdProperty = 'userId';
  static const emailsProperty = 'emails';
  static const phonesProperty = 'phoneNumbers';

  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? banner;
  String? title;
  String? company;
  DateTime? birthday;
  String? address;
  String? notes;
  int? userId;
  List<Email>? emails;
  List<Phone>? phones;

  Profile({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.banner,
    this.title,
    this.company,
    this.birthday,
    this.address,
    this.notes,
    this.userId,
    this.emails,
    this.phones,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json[idProperty];
    createdAt = json[createdAtProperty] != null
        ? DateTime.parse(json[createdAtProperty])
        : json[createdAtProperty];
    updatedAt = json[updatedAtProperty] != null
        ? DateTime.parse(json[updatedAtProperty])
        : json[updatedAtProperty];
    banner = json[bannerProperty];
    title = json[titleProperty];
    company = json[companyProperty];
    birthday = json[birthdayProperty] != null
        ? DateTime.parse(json[birthdayProperty])
        : json[birthdayProperty];
    address = json[addressProperty];
    notes = json[notesProperty];
    userId = json[userIdProperty];
    emails = List.generate(
      json[emailsProperty].length,
      (index) => Email.fromJson(
        json[emailsProperty][index],
      ),
    );
    phones = List.generate(
      json[phonesProperty].length,
      (index) => Phone.fromJson(
        json[phonesProperty][index],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        bannerProperty: banner,
        titleProperty: title,
        companyProperty: company,
        birthdayProperty: birthday!.toFormattedDateString,
        addressProperty: address,
        notesProperty: notes,
        emailsProperty: emails != null
            ? List.generate(emails!.length, (index) => emails![index].toJson())
            : emails,
        phonesProperty: phones != null
            ? List.generate(phones!.length, (index) => phones![index].toJson())
            : phones,
      };
}

class Pagination {
  static const totalProperty = 'total';
  static const lastPageProperty = 'lastPage';
  static const currentPageProperty = 'currentPage';
  static const perPageProperty = 'perPage';
  static const prevProperty = 'prev';
  static const nextProperty = 'next';

  int? total;
  int? lastPage;
  int? currentPage;
  int? perPage;
  int? prev;
  int? next;

  Pagination({
    this.total,
    this.lastPage,
    this.currentPage,
    this.perPage,
    this.prev,
    this.next,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json[totalProperty];
    lastPage = json[lastPageProperty];
    currentPage = json[currentPageProperty];
    perPage = json[perPageProperty];
    prev = json[prevProperty];
    next = json[nextProperty];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        totalProperty: total,
        lastPageProperty: lastPage,
        currentPageProperty: currentPage,
        perPageProperty: perPage,
        prevProperty: prev,
        nextProperty: next,
      };

  factory Pagination.initial() => Pagination(
        total: 0,
        lastPage: 0,
        currentPage: 0,
        perPage: 0,
        prev: null,
        next: null,
      );

  Pagination copyWith({
    int? total,
    int? lastPage,
    int? currentPage,
    int? perPage,
    int? prev,
    int? next,
  }) {
    return Pagination(
      total: total ?? this.total,
      lastPage: lastPage ?? this.lastPage,
      currentPage: currentPage ?? this.currentPage,
      perPage: perPage ?? this.perPage,
      prev: prev ?? this.prev,
      next: next ?? this.next,
    );
  }
}

class Email extends Equatable {
  static const String emailProperty = 'email';
  static const String labelProperty = 'label';

  final String? email;
  final String? label;

  const Email({
    required this.email,
    this.label,
  });

  factory Email.fromJson(Map<String, dynamic> json) => Email(
        email: json[emailProperty],
        label: json[labelProperty],
      );

  Map<String, dynamic> toJson() => {
        emailProperty: email,
        labelProperty: label,
      };

  Email copyWith({
    String? email,
    String? label,
  }) {
    return Email(
      email: email ?? this.email,
      label: label ?? this.label,
    );
  }

  @override
  List<Object?> get props => [
        email,
        label,
      ];
}

class Phone extends Equatable {
  static const String phoneProperty = 'phoneNumber';
  static const String labelProperty = 'label';
  static const String countryProperty = 'country';

  final String? phone;
  final String? label;
  final String? country;

  const Phone({
    required this.phone,
    this.label,
    this.country,
  });

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        phone: json[phoneProperty],
        label: json[labelProperty],
        country: json[countryProperty],
      );

  Map<String, dynamic> toJson() => {
        phoneProperty: phone,
        labelProperty: label,
        countryProperty: country,
      };

  Phone copyWith({
    String? phone,
    String? label,
    String? country,
  }) {
    return Phone(
      phone: phone ?? this.phone,
      label: label ?? this.label,
      country: country ?? this.country,
    );
  }

  @override
  List<Object?> get props => [
        phone,
        label,
      ];
}
