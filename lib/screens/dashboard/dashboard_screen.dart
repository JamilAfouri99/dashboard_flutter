import 'package:dashboard/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: Text('Hello from Dashboard'),
            ),
          ],
        ));
  }
}
