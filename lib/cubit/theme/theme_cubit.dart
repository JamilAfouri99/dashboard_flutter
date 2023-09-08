import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

enum AppThemeMode { light, dark }

class ThemeCubit extends Cubit<AppThemeMode> {
  ThemeCubit() : super(AppThemeMode.light);

  void toggleTheme() {
    emit(state == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light);
  }
}
