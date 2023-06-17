import 'package:dashboard/cubit/user/user_state.dart';
import 'package:dashboard/mocks/contacts.dart';
import 'package:dashboard/models/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserUnknown());

  bool isEditable = false;
  DummyUser? contact;

  Future<void> fetch(String contactId) async {
    emit(UserLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final DummyUser currentContact = mocksUsers.singleWhere((contact) => contact.id == contactId);
      contact = currentContact;
      emit(UserLoaded(contact));
    } catch (error) {
      emit(UserFailed(error.toString()));
    }
  }

  Future<void> isEditableHandler(bool editable) async {
    emit(UserLoading());
    await Future.delayed(const Duration(milliseconds: 500), () => isEditable = editable);
    emit(UserLoaded(null));
  }

  DummyUser? getUserById(String contactId) {
    return mocksUsers.firstWhere((contact) => contact.id == contactId);
  }

  Future<void> deleteUser(String contactId) async {
    emit(UserLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      DummyUser? toBeDeletedContact = getUserById(contactId);
      if (toBeDeletedContact == null) throw 'Unreachable contact';
      mocksUsers.remove(toBeDeletedContact);
      emit(UserLoaded(null));
    } catch (error) {
      emit(UserFailed(error.toString()));
    }
  }

  Future<void> addNewUser(DummyUser newContact) async {
    emit(UserLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    mocksUsers.add(newContact);
    emit(UserLoaded(null));
  }

  Future<void> updateUser(DummyUser updatedContact) async {
    print(updatedContact.emails);
    emit(UserLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    int? index = mocksUsers.indexWhere(
      (contact) => contact.id == updatedContact.id,
    );
    if (index == -1) {
      return emit(UserFailed('Fetching updated contact from dummy contacts failed'));
    }

    mocksUsers[index] = DummyUser(
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
    contact = mocksUsers[index];
    emit(UserLoaded(mocksUsers[index]));
  }
}
