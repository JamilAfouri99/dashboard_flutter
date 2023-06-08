import 'package:dashboard/cubit/contacts/contacts_state.dart';
import 'package:dashboard/mocks/contacts.dart';
import 'package:dashboard/models/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(UnknownState());

  List<Contact> _allContacts = [];
  List<Contact> _filteredContacts = [];

  Future<void> fetch() async {
    emit(LoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1));
      _allContacts = dummyContacts;
      emit(SuccessState(_allContacts));
    } catch (error) {
      emit(FailedState(error.toString()));
    }
  }

  void searchContacts(String searchText) {
    final sanitizedSearchText = searchText.trim().toLowerCase();
    if (sanitizedSearchText.isEmpty) {
      _filteredContacts = _allContacts;
    } else {
      _filteredContacts = _allContacts.where((contact) {
        final name = contact.name.toLowerCase();
        return name.contains(sanitizedSearchText);
      }).toList();
    }
    emit(SuccessState(_filteredContacts));
  }
}
