import 'package:dashboard/models/contact.dart';

abstract class UserState {}

class UserUnknown extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final DummyUser? contact;
  UserLoaded(this.contact);
}

class UserFailed extends UserState {
  final Object reason;
  UserFailed(this.reason);
}
