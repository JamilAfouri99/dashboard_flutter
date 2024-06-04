import 'package:qcarder/utils/configuration/constants.dart';
import 'package:qcarder/utils/configuration/image-constants.dart';
import 'package:qcarder/utils/configuration/theme.dart';
import 'package:qcarder/cubit/auth/auth_cubit.dart';
import 'package:qcarder/cubit/auth/auth_state.dart';
import 'package:qcarder/cubit/user_role/user_role_cubit.dart';
import 'package:qcarder/cubit/user_role/user_role_state.dart';
import 'package:qcarder/utils/helpers/role_checker.dart';
import 'package:qcarder/utils/navigation/router_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qcarder_api/api.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _dotAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse(from: 2.0);
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
    _dotAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
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
      body: BlocBuilder<UserRoleCubit, UserRoleState>(builder: (context, userRole) {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              _handleAuthenticated(context, userRole.role);
            } else if (state is UnauthenticatedState) {
              RouteManager.popAndPushNamed(
                routeName: RouteConstants.login,
                context: context,
              );
            } else if (state is AuthenticationFailed) {
              // CustomSnackbar.show(context, state.reason.toString(), type: SnackbarType.error);
              RouteManager.popAndPushNamed(
                routeName: RouteConstants.login,
                context: context,
              );
            }
          },
          // Existing BlocConsumer code...
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageConstants.letterLogo,
                    width: 150,
                  ),
                  const SizedBox(height: 50),
                  AnimatedBuilder(
                    animation: _dotAnimation,
                    builder: (context, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Dot(
                            radius: 3,
                            color: AppColors.primary,
                            animation: _dotAnimation,
                            intervalBegin: 0.0,
                            intervalEnd: 0.33,
                          ),
                          const SizedBox(width: 10),
                          Dot(
                            radius: 3,
                            color: AppColors.primary,
                            animation: _dotAnimation,
                            intervalBegin: 0.33,
                            intervalEnd: 0.66,
                          ),
                          const SizedBox(width: 10),
                          Dot(
                            radius: 3,
                            color: AppColors.primary,
                            animation: _dotAnimation,
                            intervalBegin: 0.66,
                            intervalEnd: 1.0,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  void _handleAuthenticated(BuildContext context, AuthUserRoleEnum userRole) {
    String route =
        RoleChecker.canAccessUsersScreen(userRole) ? RouteConstants.users : RouteConstants.users;

    RouteManager.popAndPushNamed(
      routeName: route,
      context: context,
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  final Animation<double> animation;
  final double intervalBegin;
  final double intervalEnd;

  const Dot({
    super.key,
    required this.radius,
    required this.color,
    required this.animation,
    required this.intervalBegin,
    required this.intervalEnd,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (animation.value - intervalBegin) / (intervalEnd - intervalBegin);
    final double scale = 1.0 + 0.5 * (1.0 - (progress.abs() * 2.0 - 1.0)).clamp(0.0, 1.0);
    final double opacity = (1.0 - progress).clamp(0.5, 1.0);

    // Reverse the animation for the second half of the cycle
    final reversedProgress = (animation.value - intervalBegin) / (intervalEnd - intervalBegin);
    final reverseOpacity = (1.0 - reversedProgress).clamp(0.1, 1.0);

    return Opacity(
      opacity: (animation.value <= intervalEnd) ? opacity : reverseOpacity,
      child: Transform.scale(
        scale:
            (animation.value <= intervalEnd) ? scale : 1.0, // Scale is 1.0 during the second half
        child: Container(
          width: radius * 1.5,
          height: radius * 1.5,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
