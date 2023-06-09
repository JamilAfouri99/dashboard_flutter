import 'package:dashboard/cubit/contact/contact_state.dart';
import 'package:dashboard/mocks/contacts.dart';
import 'package:dashboard/models/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(UnknownState());

  bool isEditable = false;
  Contact? contact;
  List<Email> emails = [];

  Future<void> fetch(String contactId) async {
    emit(LoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final Contact currentContact =
          dummyContacts.singleWhere((contact) => contact.id == contactId);
      emails = currentContact.emails;
      contact = currentContact;
      emit(SuccessState(contact));
    } catch (error) {
      emit(FailedState(error.toString()));
    }
  }

  Future<void> isEditableHandler(bool editable) async {
    emit(LoadingState());
    await Future.delayed(const Duration(milliseconds: 500), () => isEditable = editable);
    emit(SuccessState(null));
  }

  void manageEmails(Email email, {bool isRemove = false}) {
    if (isRemove) {
      emails.remove(email);
    } else {
      int index = emails.indexWhere((existingEmail) => existingEmail.id == email.id);
      if (index != -1) {
        emails[index] = email; // Update the email
      } else {
        emails.add(email); // Add email
      }
    }
    emit(SuccessState(contact!.copyWith(emails: emails)));
  }

  Contact? getContactById(String contactId) {
    return dummyContacts.firstWhere((contact) => contact.id == contactId);
  }

  Future<void> deleteContact(String contactId) async {
    emit(LoadingState());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      Contact? toBeDeletedContact = getContactById(contactId);
      if (toBeDeletedContact == null) throw 'Unreachable contact';
      dummyContacts.remove(toBeDeletedContact);
      emit(SuccessState(null));
    } catch (error) {
      emit(FailedState(error.toString()));
    }
  }

  Future<void> addNewContact(Contact newContact) async {
    emit(LoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    dummyContacts.add(newContact);
    emit(SuccessState(null));
  }
}
