import 'package:qcarder_api/api.dart';

abstract class UserState {}

class UserUnknown extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User? user;
  UserLoaded(this.user);
}

class UserFailed extends UserState {
  final Object reason;
  UserFailed(this.reason);
}
