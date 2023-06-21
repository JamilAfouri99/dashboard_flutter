import 'package:dashboard/models/user.dart';

class UserRequest {
  static const idProperty = 'id';
  static const emailProperty = 'email';
  static const firstNameProperty = 'firstName';
  static const lastNameProperty = 'lastName';
  static const avatarProperty = 'avatar';
  static const statusProperty = 'status';
  static const groupIdProperty = 'groupId';
  static const groupProperty = 'group';
  static const profileProperty = 'profile';

  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? status;
  final Profile? profile;

  UserRequest({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.status,
    this.profile,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
        id: json[idProperty],
        email: json[emailProperty],
        firstName: json[firstNameProperty],
        lastName: json[lastNameProperty],
        avatar: json[avatarProperty],
        status: json[statusProperty],
        profile: Profile.fromJson(json[profileProperty]),
      );

  Map<String, dynamic> toJson() => {
        idProperty: id,
        firstNameProperty: firstName,
        lastNameProperty: lastName,
        avatarProperty: avatar,
        emailProperty: email,
        statusProperty: status,
        profileProperty: profile != null ? profile!.toJson() : profile,
      };

  UserRequest copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
    String? status,
    Profile? profile,
  }) {
    return UserRequest(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      status: status ?? this.status,
      profile: profile ?? this.profile,
    );
  }
}
