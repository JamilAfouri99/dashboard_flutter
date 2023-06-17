import 'package:dashboard/models/user.dart';

abstract class UsersState {}

class UsersUnknown extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;
  final Pagination? pagination;

  UsersLoaded(this.users, this.pagination);
}

class UsersFailed extends UsersState {
  final Object reason;
  UsersFailed(this.reason);
}
