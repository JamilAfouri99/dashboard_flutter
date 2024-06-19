import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF524AE3);
  static const Color darkPrimary = Color(0xFF0F172A);
  static const Color onPrimary = light;
  static const Color secondary = Color(0xFF1e293b);
  static const Color onSecondary = primary;
  static const Color background = Color(0xFFf1f5f9);
  static const Color deepBackground = Color(0xFFC5E5FF);
  static const Color onTertiary = Color(0xFFFFA15C);
  static const Color tertiary = Color(0xFFFEF7EA);
  static const Color onTertiaryBold = Color(0xFF675140);
  static const Color shadow = Color(0xFFDBE5ED);
  static const Color success = Color(0xFFF1F9F4);
  static const Color onSuccess = Color(0xFF43a047);
  static const Color onSuccessBold = Color(0xFF236642);
  static const Color error = Color(0xFFFCEFEA);
  static const Color onError = Color(0xFFFF6161);
  static const Color expire = Color(0xFFFFC5CB);
  static const Color light = Colors.white;
  static const Color dark = Colors.black;
  static const Color noColor = Colors.transparent;
  static const Color grey = Color(0xFF64748B);
  static const Color lightGrey = Color.fromARGB(255, 231, 235, 241);
  static const Color errorField = Color(0xFFFAEDEF);
  static const Color stagingColor = Color(0xFFFAE9FF);
  static const Color paymentExpandedWidget = Color(0xFFF8FAFB);
  static const Color profileIconBackground = Color(0xFF1B43A2);
  static const Color cancelled = Color(0xFFFF8385);
}

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  fontFamily: 'Roboto',
  textTheme: textLightTheme,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 2,
    shadowColor: Colors.white,
    iconTheme: IconThemeData(color: AppColors.primary),
  ),
  indicatorColor: AppColors.primary,
  tabBarTheme: const TabBarTheme(labelColor: AppColors.primary),
  drawerTheme: const DrawerThemeData(backgroundColor: Colors.white, elevation: 2),
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    helperStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.grey,
    ),
    hintStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.grey,
    ),
    labelStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.grey,
    ),
    floatingLabelStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.grey,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(2),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.dark,
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
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.darkPrimary,
    inversePrimary: AppColors.secondary,
    secondary: AppColors.darkPrimary,
    onSecondary: AppColors.light,
    shadow: AppColors.grey,
    background: AppColors.light,
    onBackground: AppColors.dark,
    surface: AppColors.light,
    onSurface: AppColors.primary,
    error: AppColors.onError,
    onError: AppColors.light,
    inverseSurface: AppColors.grey,
  ).copyWith(background: AppColors.light),
);

TextTheme textLightTheme = const TextTheme(
  headlineLarge: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 44,
    color: AppColors.dark,
  ),
  headlineMedium: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: AppColors.dark,
  ),
  headlineSmall: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.dark,
  ),
  titleLarge: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: AppColors.dark,
  ),
  titleMedium: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: AppColors.dark,
  ),
  titleSmall: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: AppColors.dark,
  ),
  bodyLarge: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: AppColors.dark,
  ),
  bodyMedium: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.secondary,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.grey,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.darkPrimary,
  fontFamily: 'Roboto',
  textTheme: textDarkTheme,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkPrimary,
    elevation: 2,
    shadowColor: Colors.white,
    iconTheme: IconThemeData(color: AppColors.primary),
  ),
  indicatorColor: AppColors.primary,
  tabBarTheme: const TabBarTheme(labelColor: AppColors.primary),
  drawerTheme: const DrawerThemeData(backgroundColor: AppColors.darkPrimary, elevation: 2),
  scaffoldBackgroundColor: AppColors.darkPrimary,
  inputDecorationTheme: InputDecorationTheme(
    helperStyle: TextStyle(
      fontSize: 14,
      color: AppColors.grey.withOpacity(0.05),
    ),
    hintStyle: TextStyle(
      fontSize: 14,
      color: AppColors.grey.withOpacity(0.05),
    ),
    labelStyle: TextStyle(
      fontSize: 14,
      color: AppColors.grey.withOpacity(0.05),
    ),
    floatingLabelStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.light,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(2),
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
  colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.darkPrimary,
          onPrimary: AppColors.light,
          secondary: AppColors.primary,
          shadow: AppColors.lightGrey,
          onSecondary: AppColors.light,
          background: AppColors.darkPrimary,
          onBackground: AppColors.dark,
          onSurface: AppColors.light,
          error: AppColors.onError,
          onError: AppColors.light,
          surface: AppColors.light,
          inverseSurface: AppColors.lightGrey.withOpacity(0.05))
      .copyWith(
    background: AppColors.darkPrimary,
  ),
);

TextTheme textDarkTheme = TextTheme(
  headlineLarge: const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 44,
    color: AppColors.light,
  ),
  headlineMedium: const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: AppColors.light,
  ),
  headlineSmall: const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.light,
  ),
  titleLarge: const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
  ),
  titleMedium: const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
  ),
  titleSmall: const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14,
  ),
  bodyLarge: const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  ),
  bodyMedium: const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  ),
  bodySmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.grey.withOpacity(0.1),
  ),
);
