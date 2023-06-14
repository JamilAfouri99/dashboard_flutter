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
  static const profileIdProperty = 'profileId';
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
  int? profileId;
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
    this.profileId,
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
    profileId = json[profileIdProperty];
    group = json[groupProperty] != null ? Group.fromJson(json[groupProperty]) : null;
    profile = json[profileProperty] != null ? Profile.fromJson(json[profileProperty]) : null;
  }

  Map<String, dynamic> toJson() => {
        idProperty: id,
        createdAtProperty: createdAt,
        updatedAtProperty: updatedAt,
        emailProperty: email,
        firstNameProperty: firstName,
        lastNameProperty: lastName,
        avatarProperty: avatar,
        roleProperty: role,
        statusProperty: status,
        groupIdProperty: groupId,
        profileIdProperty: profileId,
        groupProperty: group != null ? group!.toJson() : null,
        profileProperty: profile != null ? profile!.toJson() : null,
      };
}

class Group {
  static const idProperty = 'id';
  static const createdAtProperty = 'createdAt';
  static const updatedAtProperty = 'updatedAt';
  static const nameProperty = 'name';
  static const profileIdProperty = 'profileId';

  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  int? profileId;

  Group({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.profileId,
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
    profileId = json[profileIdProperty];
  }

  Map<String, dynamic> toJson() => {
        idProperty: id,
        createdAtProperty: createdAt,
        updatedAtProperty: updatedAt,
        nameProperty: name,
        profileIdProperty: profileId,
      };
}

class Profile {
  static const idProperty = 'id';
  static const createdAtProperty = 'createdAt';
  static const updatedAtProperty = 'updatedAt';
  static const backgroundProperty = 'background';
  static const titleProperty = 'title';
  static const companyProperty = 'company';
  static const birthdayProperty = 'birthday';
  static const addressProperty = 'address';
  static const notesProperty = 'notes';

  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? background;
  String? title;
  String? company;
  DateTime? birthday;
  String? address;
  String? notes;

  Profile({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.background,
    this.title,
    this.company,
    this.birthday,
    this.address,
    this.notes,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json[idProperty];
    createdAt = json[createdAtProperty] != null
        ? DateTime.parse(json[createdAtProperty])
        : json[createdAtProperty];
    updatedAt = json[updatedAtProperty] != null
        ? DateTime.parse(json[updatedAtProperty])
        : json[updatedAtProperty];
    background = json[backgroundProperty];
    title = json[titleProperty];
    company = json[companyProperty];
    birthday = json[birthdayProperty];
    address = json[addressProperty];
    notes = json[notesProperty];
  }

  Map<String, dynamic> toJson() => {
        idProperty: id,
        createdAtProperty: createdAt,
        updatedAtProperty: updatedAt,
        backgroundProperty: background,
        titleProperty: title,
        companyProperty: company,
        birthdayProperty: birthday,
        addressProperty: address,
        notesProperty: notes,
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
}
