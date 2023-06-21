import 'package:dashboard/cubit/auth/auth_state.dart';
import 'package:dashboard/configuration/constants.dart';
import 'package:dashboard/navigation/router_manager.dart';
import 'package:dashboard/widgets/custom_button.dart';
import 'package:dashboard/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dashboard/cubit/auth/auth_cubit.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  mainAxisSize: MainAxisSize.min,
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
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
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
                        if (state is AuthenticatedState) {
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
                              final firstName = _firstNameController.text;
                              final lastName = _lastNameController.text;
                              context.read<AuthCubit>().signUp(
                                    email,
                                    password,
                                    firstName,
                                    lastName,
                                  );
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
