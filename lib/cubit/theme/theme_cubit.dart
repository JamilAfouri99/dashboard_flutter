import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder/cubit/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(ThemeMode.light));

  void toggleTheme() {
    final currentThemeMode = state.themeMode;
    emit(
      ThemeState(
        currentThemeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
