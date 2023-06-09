import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:dashboard/app.dart';
import 'package:dashboard/configuration/config.dart';
import 'package:dashboard/helpers/localization_helpers.dart';
import 'package:dashboard/services/http/my_http_overrides.dart';

Future<void> main() async {
  const environment = String.fromEnvironment('ENV', defaultValue: 'development');
  await dotenv.load(fileName: '.env.$environment');
  EnvConfig.instance;

  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/inter/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await LocalizationService.saveLocale(const Locale("en", "AE"));
  final savedLocale = await LocalizationService.savedLocale();

  runApp(MyApp(savedLocale));
}
