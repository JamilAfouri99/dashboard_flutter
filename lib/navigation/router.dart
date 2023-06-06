import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/screens/auth/login_screen.dart';
import 'package:dashboard/screens/auth/signup_screen.dart';
import 'package:dashboard/screens/contacts/contacts.dart';
import 'package:dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:dashboard/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen(), settings: settings);
      case RouteConstants.login:
        return MaterialPageRoute(builder: (_) => LoginScreen(), settings: settings);
      case RouteConstants.signUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen(), settings: settings);
      case RouteConstants.home:
        return MaterialPageRoute(builder: (_) => const DashboardScreen(), settings: settings);
      case RouteConstants.contacts:
        return MaterialPageRoute(builder: (_) => const ContactsScreen(), settings: settings);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
