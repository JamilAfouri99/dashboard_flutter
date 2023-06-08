import 'package:dashboard/cubit/contact/contact_state.dart';
import 'package:dashboard/mocks/contacts.dart';
import 'package:dashboard/models/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(UnknownState());

  bool isEditable = false;

  Future<void> fetch(String contactId) async {
    emit(LoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final Contact contact = dummyContacts.singleWhere((contact) => contact.id == contactId);
      emit(SuccessState(contact));
    } catch (error) {
      emit(FailedState(error.toString()));
    }
  }

  Future<void> isEditableHandler(bool editable) async {
    print('en');
    emit(LoadingState());
    await Future.delayed(const Duration(milliseconds: 500), () => isEditable = editable);
    emit(SuccessState(null));
  }

  Future<void> updateHandler() async {
    emit(LoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1), () => isEditable = false);
      final Contact contact = dummyContacts[0];
      emit(SuccessState(contact));
    } catch (error) {
      emit(FailedState(error.toString()));
    }
  }
}
