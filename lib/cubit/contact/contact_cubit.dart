import 'package:dashboard/cubit/contact/contact_state.dart';
import 'package:dashboard/mocks/contacts.dart';
import 'package:dashboard/models/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(UnknownState());

  bool isEditable = false;
  Contact? contact;

  Future<void> fetch(String contactId) async {
    emit(LoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final Contact currentContact =
          dummyContacts.singleWhere((contact) => contact.id == contactId);
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

  Future<void> updateContact(Contact updatedContact) async {
    print(updatedContact.emails);
    emit(LoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    int? index = dummyContacts.indexWhere(
      (contact) => contact.id == updatedContact.id,
    );
    if (index == -1) {
      return emit(FailedState('Fetching updated contact from dummy contacts failed'));
    }

    dummyContacts[index] = Contact(
      id: updatedContact.id,
      name: updatedContact.name,
      image: updatedContact.image,
      categories: updatedContact.categories,
      title: updatedContact.title,
      company: updatedContact.company,
      emails: updatedContact.emails,
      phones: updatedContact.phones,
      address: updatedContact.address,
      birthday: updatedContact.birthday,
      note: updatedContact.note,
    );
    contact = dummyContacts[index];
    emit(SuccessState(dummyContacts[index]));
  }
}
