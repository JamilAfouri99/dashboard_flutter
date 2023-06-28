import 'package:qcarder_api/api.dart';

abstract class UsersState {}

class UsersUnknown extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final PaginatedUsers paginatedUsers;

  UsersLoaded(this.paginatedUsers);
}

class UsersFailed extends UsersState {
  final Object reason;
  UsersFailed(this.reason);
}
