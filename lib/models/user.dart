import 'package:dashboard/helpers/date_time.dart';
import 'package:equatable/equatable.dart';

class UsersResponse {
  static const usersProperty = 'data';
  static const paginationProperty = 'meta';

  final List<User> users;
  final Pagination pagination;

  UsersResponse({required this.users, required this.pagination});

  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    return UsersResponse(
      users: List.generate(
        json[usersProperty].length,
        (i) => User.fromJson(json[usersProperty][i]),
      ),
      pagination: Pagination.fromJson(
        json[paginationProperty],
      ),
    );
  }

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

  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String email;
  final String firstName;
  final String lastName;
  final String? avatar;
  final String role;
  final String status;
  final int? groupId;
  final Group group;
  final Profile profile;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.avatar,
    required this.role,
    required this.status,
    this.groupId,
    required this.group,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json[idProperty],
        createdAt: DateTime.parse(json[createdAtProperty]),
        updatedAt: DateTime.parse(json[updatedAtProperty]),
        email: json[emailProperty],
        firstName: json[firstNameProperty],
        lastName: json[lastNameProperty],
        avatar: json[avatarProperty],
        role: json[roleProperty],
        status: json[statusProperty],
        groupId: json[groupIdProperty],
        group: Group.fromJson(json[groupProperty]),
        profile: Profile.fromJson(json[profileProperty]),
      );

  Map<String, dynamic> toJson() => {
        firstNameProperty: firstName,
        lastNameProperty: lastName,
        avatarProperty: avatar,
        emailProperty: email,
        // roleProperty: role,
        statusProperty: status,
        groupIdProperty: groupId,
        groupProperty: group.toJson(),
        profileProperty: profile.toJson(),
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

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? banner;
  final String? title;
  final String? company;
  final DateTime? birthday;
  final String? address;
  final String? notes;
  final int? userId;
  final List<Email>? emails;
  final List<Phone>? phones;

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

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json[idProperty],
        createdAt: json[createdAtProperty] != null
            ? DateTime.parse(json[createdAtProperty])
            : json[createdAtProperty],
        updatedAt: json[updatedAtProperty] != null
            ? DateTime.parse(json[updatedAtProperty])
            : json[updatedAtProperty],
        banner: json[bannerProperty],
        title: json[titleProperty],
        company: json[companyProperty],
        birthday: json[birthdayProperty] != null
            ? DateTime.parse(json[birthdayProperty])
            : json[birthdayProperty],
        address: json[addressProperty],
        notes: json[notesProperty],
        userId: json[userIdProperty],
        emails: json[emailsProperty] != null
            ? List.generate(
                json[emailsProperty].length,
                (index) => Email.fromJson(
                  json[emailsProperty][index],
                ),
              )
            : json[emailsProperty],
        phones: json[phonesProperty] != null
            ? List.generate(
                json[phonesProperty].length,
                (index) => Phone.fromJson(
                  json[phonesProperty][index],
                ),
              )
            : json[phonesProperty],
      );

  Map<String, dynamic> toJson() => {
        bannerProperty: banner,
        titleProperty: title,
        companyProperty: company,
        birthdayProperty: birthday != null ? birthday!.toFormattedDateString : birthday,
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
