import 'package:qcarder/configuration/config.dart';
import 'package:flutter/material.dart';
import 'package:qcarder_api/api.dart';

class KeysService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState>? snackbarKey = GlobalKey<ScaffoldMessengerState>();
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
}

class ClientService {
  static final apiClient = ApiClient(basePath: EnvConfig.instance.baseUrl);
}
