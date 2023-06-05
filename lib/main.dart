import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dashboard/app.dart';
import 'package:dashboard/helpers/localization_helpers.dart';
import 'package:dashboard/services/error/network_exceptions.dart';
import 'package:dashboard/services/http/my_http_overrides.dart';
import 'package:dashboard/services/navigation_service.dart';
import 'package:dashboard/widgets/restart_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runZonedGuarded(() async {
    HttpOverrides.global = MyHttpOverrides();
    WidgetsFlutterBinding.ensureInitialized();
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('assets/fonts/roboto/LICENSE.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });
    // initialSetup(); //TODO: implement this
    await LocalizationService.saveLocale(const Locale("en", "AE"));
    final savedLocale = await LocalizationService.savedLocale();

    runApp(RestartWidget(child: MyApp(savedLocale)));
  }, (error, stackTrace) {
    if (error is DioError) {
      final BuildContext context = NavigationService.navigatorKey.currentContext!;
      String message = NetworkExceptions.getDioException(error) as String;
      if (message.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  });
}
