import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1247C2);
  static const Color onPrimary = light;
  static const Color secondary = Color(0xFFE2F3FF);
  static const Color onSecondary = primary;
  static const Color background = Color(0xFFF3FAFF);
  static const Color deepBackground = Color(0xFFC5E5FF);
  static const Color onTertiary = Color(0xFFFFA15C);
  static const Color tertiary = Color(0xFFFEF7EA);
  static const Color onTertiaryBold = Color(0xFF675140);
  static const Color shadow = Color(0xFFDBE5ED);
  static const Color success = Color(0xFFF1F9F4);
  static const Color onSuccess = Color(0xFF36BB74);
  static const Color onSuccessBold = Color(0xFF236642);
  static const Color error = Color(0xFFFCEFEA);
  static const Color onError = Color(0xFFFF6161);
  static const Color expire = Color(0xFFFFC5CB);
  static const Color light = Colors.white;
  static const Color dark = Colors.black;
  static const Color noColor = Colors.transparent;
  static const Color grey = Color(0xFF515966);
  static const Color errorField = Color(0xFFFAEDEF);
  static const Color stagingColor = Color(0xFFFAE9FF);
  static const Color paymentExpandedWidget = Color(0xFFF8FAFB);
  static const Color profileIconBackground = Color(0xFF1B43A2);
  static const Color cancelled = Color(0xFFFF8385);
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.light,
    secondary: AppColors.secondary,
    onSecondary: AppColors.light,
    background: AppColors.secondary,
    onBackground: AppColors.dark,
    surface: AppColors.light,
    onSurface: AppColors.primary,
    error: AppColors.onError,
    onError: AppColors.light,
  ),
  fontFamily: 'Roboto',
  textTheme: textTheme,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 2,
    shadowColor: Colors.white,
    iconTheme: IconThemeData(color: AppColors.primary),
  ),
  indicatorColor: AppColors.primary,
  tabBarTheme: const TabBarTheme(labelColor: AppColors.primary),
  drawerTheme: const DrawerThemeData(backgroundColor: Colors.white, elevation: 2),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  ),
  iconTheme: const IconThemeData(color: AppColors.primary),
);

TextTheme textTheme = const TextTheme(
  headlineLarge: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 44,
  ),
  headlineMedium: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
  ),
  headlineSmall: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  ),
  titleLarge: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
  ),
  titleMedium: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
  ),
  titleSmall: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14,
  ),
  bodyLarge: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  ),
  bodyMedium: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  ),
  bodySmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.grey,
  ),
);
