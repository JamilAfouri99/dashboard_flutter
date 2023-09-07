import 'package:flutter/material.dart';
import 'package:qcarder/configuration/constants.dart';
import 'package:qcarder/navigation/router_manager.dart';
import 'package:qcarder/widgets/app_bar.dart';
import 'package:qcarder/widgets/error.dart';

class NotFoundScreen extends StatelessWidget {
  final String msg;
  const NotFoundScreen({super.key, this.msg = 'Not found'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(
        title: 'Not Found',
      ),
      body: GlobalErrorWidget(
        title: '404',
        message: msg,
        onRetryPressed: () => RouteManager.pushAndRemoveAll(
          routeName: RouteConstants.users,
          context: context,
        ),
      ),
    );
  }
}
