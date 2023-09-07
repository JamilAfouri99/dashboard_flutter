import 'package:bloc/bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false); // Initial state is not dark theme

  void toggleDarkTheme() {
    emit(!state); // Toggle the dark theme state
  }
}
