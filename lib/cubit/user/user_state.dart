import 'package:dashboard/models/contact.dart';

abstract class UserState {}

class UnknownState extends UserState {}

class LoadingState extends UserState {}

class SuccessState extends UserState {
  final DummyUser? contact;
  SuccessState(this.contact);
}

class FailedState extends UserState {
  final Object reason;
  FailedState(this.reason);
}
