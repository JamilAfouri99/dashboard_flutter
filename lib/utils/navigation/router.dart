import 'package:flutter/material.dart';
import 'package:qcarder/utils/configuration/constants.dart';
import 'package:qcarder/screens/auth/signin_screen.dart';
import 'package:qcarder/screens/dashboard/dashboard_screen.dart';
import 'package:qcarder/screens/nfc/nfc_screen.dart';
import 'package:qcarder/screens/notfound/notfound_screen.dart';
import 'package:qcarder/screens/splash/splash_screen.dart';
import 'package:qcarder/screens/user/user_screen.dart';
import 'package:qcarder/screens/users/users.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routeName = settings.name;
    final builder = _routeBuilders[routeName] ?? _getDynamicRouteBuilder(routeName);

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }

  static final Map<String, WidgetBuilder> _routeBuilders = {
    RouteConstants.splash: (_) => const SplashScreen(),
    RouteConstants.login: (_) => const SigninScreen(),
    RouteConstants.signUp: (_) => const SigninScreen(),
    RouteConstants.home: (_) => const DashboardScreen(),
    RouteConstants.users: (_) => UsersScreen(),
    RouteConstants.nfc: (_) => NfcScreen(),
  };

  static WidgetBuilder _getDynamicRouteBuilder(String? routeName) {
    if (routeName != null && routeName.startsWith(RouteConstants.users)) {
      final userId = routeName.replaceFirst(RouteConstants.users, '').replaceAll('/', '');
      return (_) => UserScreen(userId: userId);
    } else {
      return (_) => NotFoundScreen(msg: 'No route defined for $routeName');
    }
  }
}
