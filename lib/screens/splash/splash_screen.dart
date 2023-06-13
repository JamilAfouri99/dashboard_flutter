import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/cubit/auth/auth_cubit.dart';
import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/widgets/custom_progress_indicator.dart';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            RouteManager.routerManagerPopAndPushNamed(
              routeName: RouteConstants.users,
              context: context,
            );
          } else if (state is UnauthenticatedState) {
            RouteManager.routerManagerPopAndPushNamed(
              routeName: RouteConstants.login,
              context: context,
            );
          } else if (state is AuthenticationFailed) {
            CustomSnackbar.show(context, state.reason.toString());
            RouteManager.routerManagerPopAndPushNamed(
              routeName: RouteConstants.login,
              context: context,
            );
          }
        },
        builder: (context, state) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CustomProgressIndicator()],
            ),
          );
        },
      ),
    );
  }
}
