import 'package:flutter/material.dart';

class RouteManager {
  static navigateTo(
      {required String routeName, required BuildContext context}) {
    Navigator.of(context).pushNamed(routeName);
  }

  static pushAndRemoveAll(
      {required String routeName, required BuildContext context}) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  static popAndPushNamed(
      {required String routeName, required BuildContext context}) {
    Navigator.of(context).popAndPushNamed(routeName);
  }

  static navigateWithData<T>(BuildContext context, Widget Function() builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: (data) => builder()));
  }

  static pushAndRemoveAllWithData<T>(
      BuildContext context, Widget Function() builder) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (data) => builder()),
      (Route<dynamic> route) => false,
    );
  }

  static pushAndRemoveCurrentWithData<T>(
    BuildContext context,
    Widget Function() builder,
  ) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (data) => builder()),
      (Route<dynamic> route) => route.isFirst,
    );
  }
}
