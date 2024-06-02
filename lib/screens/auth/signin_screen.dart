import 'package:qcarder/utils/configuration/image-constants.dart';
import 'package:qcarder/utils/configuration/theme.dart';
import 'package:qcarder/cubit/auth/auth_state.dart';
import 'package:qcarder/utils/configuration/constants.dart';
import 'package:qcarder/utils/navigation/router_manager.dart';
import 'package:qcarder/screens/auth/password_widget.dart';
import 'package:qcarder/widgets/custom_button.dart';
import 'package:qcarder/widgets/custom_progress_indicator.dart';
import 'package:qcarder/widgets/custom_text_field.dart';
import 'package:qcarder/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcarder/cubit/auth/auth_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qcarder_api/api.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    SigninDto? savedCredentials = await context.read<AuthCubit>().getSavedCredentials();
    if (savedCredentials != null) {
      _emailController.text = savedCredentials.email;
      _passwordController.text = savedCredentials.password;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80, bottom: 50),
            child: SvgPicture.asset(
              ImageConstants.fullLogo,
              width: 70,
              height: 70,
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextField(
                          labelText: 'Email',
                          hintText: 'user@qcarder.com',
                          controller: _emailController,
                          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
                              ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        PasswordField(_passwordController),
                        const SizedBox(height: 5.0),
                        BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                          bool isRemember = context.read<AuthCubit>().rememberMe;
                          return Row(
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  context.read<AuthCubit>().rememberMe = !isRemember;
                                  setState(() => {});
                                },
                                icon: Icon(
                                  isRemember ? Icons.check_box : Icons.check_box_outline_blank,
                                  size: 28,
                                  color: isRemember
                                      ? AppColors.primary
                                      : Theme.of(context).colorScheme.shadow.withOpacity(0.6),
                                ),
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                                  ),
                                  child: Text(
                                    'Remember me',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  onPressed: () {
                                    context.read<AuthCubit>().rememberMe = !isRemember;
                                    setState(() => {});
                                  }),
                            ],
                          );
                        }),
                        const SizedBox(height: 5.0),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthenticationFailed) {
                              CustomSnackbar.show(
                                context,
                                state.reason.toString(),
                                type: SnackbarType.error,
                              );
                            } else if (state is AuthenticatedState) {
                              RouteManager.pushAndRemoveAll(
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
                              title: 'Sign in',
                              onPressed: () async {
                                final form = Form.of(context);
                                if (form.validate()) {
                                  form.save();
                                  final email = _emailController.text.trim();
                                  final password = _passwordController.text.trim();
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
          ),
        ],
      ),
    );
  }
}
