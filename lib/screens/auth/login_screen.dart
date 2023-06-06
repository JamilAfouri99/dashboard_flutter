import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/configuration/theme.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dashboard/cubit/auth/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

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
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthenticationFailed) {
                          CustomSnackbar.show(
                            context,
                            state.reason.toString(),
                            type: SnackbarType.error,
                          );
                        } else if (state is AuthenticatedState) {
                          RouteManager().routerManagerPushUntil(
                            routeName: RouteConstants.home,
                            context: context,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthenticatingState) {
                          return const CircularProgressIndicator();
                        }
                        return ElevatedButton(
                          onPressed: () async {
                            final form = Form.of(context);
                            if (form.validate()) {
                              form.save();
                              final email = _emailController.text;
                              final password = _passwordController.text;
                              context.read<AuthCubit>().login(email, password);
                            }
                          },
                          child: const Text('Login'),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        RouteManager().routerManager(
                          routeName: RouteConstants.signUp,
                          context: context,
                        );
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
