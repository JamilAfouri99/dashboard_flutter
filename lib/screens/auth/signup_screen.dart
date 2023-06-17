import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/widgets/custom_button.dart';
import 'package:dashboard/widgets/custom_progress_indicator.dart';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dashboard/cubit/auth/auth_cubit.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: FlutterLogo(size: 150),
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
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
                          title: 'Signup'.toUpperCase(),
                          onPressed: () async {
                            final form = Form.of(context);
                            if (form.validate()) {
                              form.save();
                              final email = _emailController.text;
                              final password = _passwordController.text;
                              // final confirmed = _confirmPasswordController.text;
                              context.read<AuthCubit>().signUp(email, password);
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: context.watch<AuthCubit>().state is AuthenticatingState
                          ? null
                          : () {
                              RouteManager.routerManager(
                                routeName: RouteConstants.login,
                                context: context,
                              );
                            },
                      child: const Text('Already have an account? Log in'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
