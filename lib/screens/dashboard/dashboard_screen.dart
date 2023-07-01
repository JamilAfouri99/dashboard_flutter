import 'package:qcarder/cubit/auth/auth_cubit.dart';
import 'package:qcarder/cubit/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Contacts', style: Theme.of(context).textTheme.titleLarge),
          actions: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    await context.read<AuthCubit>().remoteLogout(context);
                  },
                );
              },
            ),
          ],
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: Text('Hello from qcarder'),
            ),
          ],
        ));
  }
}
