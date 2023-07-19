import 'package:qcarder/configuration/image_constants.dart';
import 'package:qcarder/configuration/theme.dart';
import 'package:qcarder/cubit/auth/auth_state.dart';
import 'package:qcarder/configuration/constants.dart';
import 'package:qcarder/navigation/router_manager.dart';
import 'package:qcarder/screens/auth/password_widget.dart';
import 'package:qcarder/widgets/custom_button.dart';
import 'package:qcarder/widgets/custom_progress_indicator.dart';
import 'package:qcarder/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder/cubit/auth/auth_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qcarder_api/api.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80, bottom: 50),
            child: SvgPicture.asset(
              ImageConstants.fullLogo,
              width: 80,
              height: 80,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'user@qcarder.com',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      // TextFormField(
                      //   controller: _passwordController,
                      //   decoration: const InputDecoration(
                      //     labelText: 'Password',
                      //   ),
                      //   obscureText: true,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your password';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      PasswordField(_passwordController),
                      const SizedBox(height: 16.0),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthenticationFailed) {
                            CustomSnackbar.show(
                              context,
                              state.reason.toString(),
                              type: SnackbarType.error,
                            );
                          } else if (state is AuthenticatedState) {
                            RouteManager.routerManagerPushUntil(
                              routeName: RouteConstants.users,
                              context: context,
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthenticatingState) {
                            return const CustomProgressIndicator();
                          }
                          return CustomButton(
                            title: 'Login'.toUpperCase(),
                            onPressed: () async {
                              final form = Form.of(context);
                              if (form.validate()) {
                                form.save();
                                final email = _emailController.text;
                                final password = _passwordController.text;
                                context
                                    .read<AuthCubit>()
                                    .signIn(SigninDto(email: email, password: password));
                              }
                            },
                          );
                        },
                      ),
                      // const SizedBox(height: 16.0),
                      // TextButton(
                      //   onPressed: context.watch<AuthCubit>().state is AuthenticatingState
                      //       ? null
                      //       : () {
                      //           RouteManager.routerManager(
                      //             routeName: RouteConstants.signUp,
                      //             context: context,
                      //           );
                      //         },
                      //   child: const Text('Don\'t have an account? Sign up'),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
