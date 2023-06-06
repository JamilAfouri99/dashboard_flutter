import 'package:dashboard/models/contact.dart';

abstract class ContactsState {}

class UnknownState extends ContactsState {}

class LoadingState extends ContactsState {}

class SuccessState extends ContactsState {
  final List<Contact> contacts;
  SuccessState(this.contacts);
}

class FailedState extends ContactsState {
  final Object reason;
  FailedState(this.reason);
}
