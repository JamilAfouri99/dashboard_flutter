import 'package:dashboard/cubit/auth/auth_cubit.dart';
import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final appBar = AppBar(
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
);
