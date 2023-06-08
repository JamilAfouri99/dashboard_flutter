import 'package:dashboard/cubit/auth/auth_cubit.dart';
import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:dashboard/services/error/network_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final appBar = AppBar(
  centerTitle: true,
  title: Text('Contacts', style: Theme.of(context).textTheme.titleLarge),
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
