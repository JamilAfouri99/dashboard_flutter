import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qcarder/app.dart';
import 'package:qcarder/configuration/config.dart';
import 'package:qcarder/helpers/localization_helpers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _envInit();
  await _googleLicenseInit();
  final locale = await _localizationInit();
  await Firebase.initializeApp();
  
  runApp(MyApp(locale));
}

Future<void> _envInit() async {
  const environment = String.fromEnvironment('ENV', defaultValue: 'development');
  await dotenv.load(fileName: '.env.$environment');
  EnvConfig.instance;
}

Future<Locale> _localizationInit() async {
  await LocalizationService.saveLocale(const Locale('en', 'AE'));
  final savedLocale = await LocalizationService.savedLocale();
  return savedLocale;
}

Future<void> _googleLicenseInit() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/inter/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}
