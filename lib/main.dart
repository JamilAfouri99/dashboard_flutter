import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:qcarder/app.dart';
import 'package:qcarder/configuration/config.dart';
import 'package:qcarder/helpers/localization_helpers.dart';

Future<void> main() async {
  const environment = String.fromEnvironment('ENV', defaultValue: 'development');
  await dotenv.load(fileName: '.env.$environment');
  EnvConfig.instance;

  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/inter/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await LocalizationService.saveLocale(const Locale('en', 'AE'));
  final savedLocale = await LocalizationService.savedLocale();

  // await downloadApp();

  runApp(MyApp(savedLocale));
}
