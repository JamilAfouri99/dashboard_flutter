import 'package:dashboard/models/user.dart';

abstract class UsersState {}

class UnknownState extends UsersState {}

class LoadingState extends UsersState {}

class SuccessState extends UsersState {
  final List<User> users;
  SuccessState(this.users);
}

class FailedState extends UsersState {
  final Object reason;
  FailedState(this.reason);
}
