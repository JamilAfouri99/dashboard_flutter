import 'package:dashboard/models/tokens.dart';
import 'package:equatable/equatable.dart';

class LoggedInUser extends Equatable {
  static const String idProperty = 'id';
  static const String emailProperty = 'email';
  static const String firstNameProperty = 'firstName';
  static const String lastNameProperty = 'lastName';
  static const String avatarProperty = 'avatar';
  static const String roleProperty = 'role';
  static const String statusProperty = 'status';
  static const String groupIdProperty = 'groupId';
  static const String profileIdProperty = 'profileId';
  static const String accessTokenProperty = 'access_token';
  static const String refreshTokenProperty = 'refresh_token';

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String? avatar;
  final String role;
  final String status;
  final int groupId;
  final int? profileId;
  final AccessToken accessToken;
  final RefreshToken refreshToken;

  const LoggedInUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.role,
    required this.status,
    required this.groupId,
    required this.profileId,
    required this.accessToken,
    required this.refreshToken,
  });
  factory LoggedInUser.fromJson(Map<String, dynamic> json) => LoggedInUser(
        id: json[idProperty],
        email: json[emailProperty],
        firstName: json[firstNameProperty],
        lastName: json[lastNameProperty],
        avatar: json[avatarProperty],
        role: json[roleProperty],
        status: json[statusProperty],
        groupId: json[groupIdProperty],
        profileId: json[profileIdProperty],
        accessToken: AccessToken(json[accessTokenProperty]),
        refreshToken: RefreshToken(json[refreshTokenProperty]),
      );

  Map<String, dynamic> toJson() => {
        idProperty: id,
        emailProperty: email,
        firstNameProperty: firstName,
        lastNameProperty: lastName,
        avatarProperty: avatar,
        roleProperty: role,
        statusProperty: status,
        groupIdProperty: groupId,
        profileIdProperty: profileId,
        accessTokenProperty: accessToken,
        refreshTokenProperty: refreshToken,
      };

  LoggedInUser copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
    String? role,
    String? status,
    int? groupId,
    int? profileId,
    AccessToken? accessToken,
    RefreshToken? refreshToken,
  }) {
    return LoggedInUser(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      status: status ?? this.status,
      groupId: groupId ?? this.groupId,
      profileId: profileId ?? this.profileId,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        avatar,
        role,
        status,
        groupId,
        profileId,
        accessToken,
        refreshToken,
      ];
}
