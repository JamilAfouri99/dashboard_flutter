import 'package:qcarder/configuration/constants.dart';
import 'package:qcarder/screens/auth/login_screen.dart';
import 'package:qcarder/screens/dashboard/dashboard_screen.dart';
import 'package:qcarder/screens/nfc/nfc_screen.dart';
import 'package:qcarder/screens/splash/splash_screen.dart';
import 'package:qcarder/screens/user/user_screen.dart';
import 'package:qcarder/screens/users/users.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen(), settings: settings);
      case RouteConstants.login:
        return MaterialPageRoute(builder: (_) => LoginScreen(), settings: settings);
      case RouteConstants.signUp:
        return MaterialPageRoute(builder: (_) => LoginScreen(), settings: settings);
      case RouteConstants.home:
        return MaterialPageRoute(builder: (_) => const DashboardScreen(), settings: settings);
      case RouteConstants.users:
        return MaterialPageRoute(builder: (_) => const UsersScreen(), settings: settings);
      case RouteConstants.user:
        return MaterialPageRoute(builder: (_) => const UserScreen(), settings: settings);
      case RouteConstants.nfc:
        return MaterialPageRoute(builder: (_) => NfcScreen(), settings: settings);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
