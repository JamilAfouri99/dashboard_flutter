import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dashboard/cubit/auth/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                  .login(_emailController.text, _passwordController.text);
                            }
                          },
                          child: const Text('Login'),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        RouteManager()
                            .routerManager(routeName: RouteConstants.signUp, context: context);
                      },
                      child: const Text('Don\'t have an account? Sign up'),
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
