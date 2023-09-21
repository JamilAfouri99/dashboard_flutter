// import 'package:qcarder/configuration/constants.dart';
// import 'package:qcarder/screens/auth/signin_screen.dart';
// import 'package:qcarder/screens/dashboard/dashboard_screen.dart';
// import 'package:qcarder/screens/nfc/nfc_screen.dart';
// import 'package:qcarder/screens/notfound/notfound_screen.dart';
// import 'package:qcarder/screens/splash/splash_screen.dart';
// import 'package:qcarder/screens/user/user_screen.dart';
// import 'package:qcarder/screens/users/users.dart';
// import 'package:flutter/material.dart';

// class Router {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     String? userId = getUserId(settings.name);

//     if (userId != null) {
//       return MaterialPageRoute(
//         builder: (_) => UserScreen(userId: userId),
//         settings: settings,
//       );
//     }

//     switch (settings.name) {
//       case RouteConstants.splash:
//         return MaterialPageRoute(builder: (_) => const SplashScreen(), settings: settings);
//       case RouteConstants.login:
//         return MaterialPageRoute(builder: (_) => const SigninScreen(), settings: settings);
//       case RouteConstants.signUp:
//         return MaterialPageRoute(builder: (_) => const SigninScreen(), settings: settings);
//       case RouteConstants.home:
//         return MaterialPageRoute(builder: (_) => const DashboardScreen(), settings: settings);
//       case RouteConstants.users:
//         return MaterialPageRoute(builder: (_) => const UsersScreen(), settings: settings);
//       case RouteConstants.user:
//         return MaterialPageRoute(builder: (_) => const UserScreen(), settings: settings);
//       case RouteConstants.nfc:
//         return MaterialPageRoute(builder: (_) => NfcScreen(), settings: settings);

//       default:
//         return MaterialPageRoute(
//             builder: (_) => NotFoundScreen(msg: 'No route defined for ${settings.name}'));
//     }
//   }

//   static String? getUserId(String? routeName) {
//     if (routeName != null) {
//       final userIndex = routeName.indexOf(RouteConstants.users);
//       if (userIndex != -1) {
//         final idIndex = userIndex + RouteConstants.users.length + 1;
//         if (idIndex < routeName.length) {
//           return routeName.substring(idIndex);
//         }
//       }
//     }
//     return null;
//   }
// }

import 'package:flutter/material.dart';
import 'package:qcarder/configuration/constants.dart';
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
    RouteConstants.users: (_) => const UsersScreen(),
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
