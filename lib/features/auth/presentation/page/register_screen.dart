import 'package:bookia_app/core/constants/app_assets.dart';
import 'package:bookia_app/core/functions/dialogs.dart';
import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/functions/validation.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_button.dart';
import 'package:bookia_app/core/widgets/nav_bar_widget.dart';
import 'package:bookia_app/features/auth/data/model/request/user_model_params.dart';
import 'package:bookia_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookia_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:bookia_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            showLoadingDialog(context);
          } else if (state is RegisterSuccessState) {
            pushAndRemoveUntil(context, const NavBarWidget());
          } else if (state is AuthErrorState) {
            Navigator.pop(context);
            showAppDialog(context, state.message);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    'Hello! Register to get started',
                    style: getFont30TextStyle(),
                  ),
                  const Gap(32),
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      } else if (!emailValidation(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 17, maxWidth: 53),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: SvgPicture.asset(AppAssets.eye),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                        hintText: 'Confirm password',
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 17, maxWidth: 53),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: SvgPicture.asset(AppAssets.eye),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm Password is required';
                      } else if (value.length < 8) {
                        return 'Confirm Password must be at least 8 characters';
                      } else if (passwordController.text != value) {
                        return 'Password and Confirm Password must be same';
                      }
                      return null;
                    },
                  ),
                  const Gap(30),
                  CustomButton(
                    text: 'Register',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context
                            .read<AuthBloc>()
                            .add(RegisterEvent(UserModelParams(
                              email: emailController.text,
                              name: usernameController.text,
                              password: passwordController.text,
                              passwordConfirmation:
                                  confirmPasswordController.text,
                            )));
                      }
                    },
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style:
                            getFont16TextStyle(color: AppColors.darkGreyColor),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Sign in',
                            style: getFont16TextStyle(
                                color: AppColors.primaryColor),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
