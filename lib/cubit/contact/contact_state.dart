import 'package:dashboard/models/contact.dart';

abstract class ContactState {}

class UnknownState extends ContactState {}

class LoadingState extends ContactState {}

class SuccessState extends ContactState {
  final Contact? contact;
  SuccessState(this.contact);
}

class FailedState extends ContactState {
  final Object reason;
  FailedState(this.reason);
}
