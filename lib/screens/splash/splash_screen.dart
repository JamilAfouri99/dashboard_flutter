import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/configuration/image_constants.dart';
import 'package:dashboard/cubit/auth/auth_cubit.dart';
import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
            CustomSnackbar.show(context, state.reason.toString(), type: SnackbarType.error);
            RouteManager.routerManagerPopAndPushNamed(
              routeName: RouteConstants.login,
              context: context,
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageConstants.letterLogo,
                    width: 150,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
