import 'package:flutter/material.dart';

class RouteManager {
  static routerManager({required String routeName, required BuildContext context}) {
    Navigator.of(context).pushNamed(routeName);
  }

  static routerManagerPushUntil({required String routeName, required BuildContext context}) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  static routerManagerPopAndPushNamed({required String routeName, required BuildContext context}) {
    Navigator.of(context).popAndPushNamed(routeName);
  }

  static navigateToWithData<T>(BuildContext context, Widget Function() builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: (data) => builder()));
  }
}
