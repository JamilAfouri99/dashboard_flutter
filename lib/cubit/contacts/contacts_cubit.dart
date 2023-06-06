import 'package:dashboard/cubit/contacts/contacts_state.dart';
import 'package:dashboard/mocks/contacts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(UnknownState());

  Future<void> fetch() async {
    emit(LoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(SuccessState(dummyContacts));
    } catch (error) {
      emit(FailedState(error.toString()));
    }
  }
}
