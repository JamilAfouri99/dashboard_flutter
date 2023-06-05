import 'package:dashboard/configuration/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService {
  static saveLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("Language Code", locale.languageCode);
    if (locale.countryCode != null) {
      await prefs.setString("Country Code", locale.countryCode!);
    }
  }

  static Future<Locale> savedLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var savedLanguageCode = prefs.getString(KeyConstants.languageCode);
    var savedCountryCode = prefs.getString(KeyConstants.countryCode);
    var savedLocale = const Locale("ar", "JO");

    if (savedCountryCode != null && savedLanguageCode != null) {
      savedLocale = Locale(savedLanguageCode, savedCountryCode);
    }

    return savedLocale;
  }
}
