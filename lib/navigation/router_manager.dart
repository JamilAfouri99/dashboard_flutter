import 'package:flutter/material.dart';

class RouteManager {
  routerManager({required String routeName, required BuildContext context}) {
    Navigator.of(context).pushNamed(routeName);
  }

  routerManagerPushUntil({required String routeName, required BuildContext context}) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  routerManagerPopAndPushNamed({required String routeName, required BuildContext context}) {
    Navigator.of(context).popAndPushNamed(routeName);
  }
}
