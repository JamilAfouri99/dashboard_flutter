import 'package:dashboard/cubit/auth/auth_cubit.dart';
import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FlutterLogo(
                size: 100,
              ),
              const SizedBox(height: 32.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      key: const Key('email'),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: const Key('password'),
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: const Key('confirmPassword'),
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      obscureText: true,
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthenticatingState) {
                    return const CircularProgressIndicator();
                  }
                  if (state is AuthenticationFailed) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      CustomSnackbar.show(
                        context,
                        state.reason.toString(),
                        type: SnackbarType.error,
                      );
                    });
                  } else if (state is AuthenticatedState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      RouteManager().routerManagerPushUntil(
                        routeName: RouteConstants.home,
                        context: context,
                      );
                    });
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<AuthCubit>()
                            .signUp(_emailController.text, _passwordController.text);
                      }
                    },
                    child: const Text('Sign Up'),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  RouteManager().routerManager(routeName: RouteConstants.login, context: context);
                },
                child: const Text('Already have an account? Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
