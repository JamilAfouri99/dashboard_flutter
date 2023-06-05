import 'package:dashboard/cubit/auth/auth_cubit.dart';
import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    await context.read<AuthCubit>().logout(context);
                  },
                );
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: Text('Hello from Dashboard'),
            ),
          ],
        ));
  }
}
