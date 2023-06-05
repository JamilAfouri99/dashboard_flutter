import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/screens/auth/login_screen.dart';
import 'package:dashboard/screens/auth/signup_screen.dart';
import 'package:dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:dashboard/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.home:
        return MaterialPageRoute(builder: (_) => const DashboardScreen(), settings: settings);
      case RouteConstants.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen(), settings: settings);
      case RouteConstants.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen(), settings: settings);
      case RouteConstants.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen(), settings: settings);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
