import 'package:bookia_app/core/constants/app_assets.dart';
import 'package:bookia_app/core/functions/dialogs.dart';
import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_button.dart';
import 'package:bookia_app/core/widgets/nav_bar_widget.dart';
import 'package:bookia_app/features/auth/data/model/request/user_model_params.dart';
import 'package:bookia_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookia_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:bookia_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:bookia_app/features/auth/presentation/page/register_screen.dart';
import 'package:bookia_app/features/auth/presentation/widgets/or_divider.dart';
import 'package:bookia_app/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            showLoadingDialog(context);
          } else if (state is LoginSuccessState) {
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
                    'Welcome back! Glad to see you, Again!',
                    style: getFont30TextStyle(),
                  ),
                  const Gap(32),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Enter your password',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: getFont14TextStyle(
                                color: AppColors.darkGreyColor),
                          )),
                    ],
                  ),
                  const Gap(20),
                  CustomButton(
                      text: 'Login',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context
                              .read<AuthBloc>()
                              .add(LoginEvent(UserModelParams(
                                email: emailController.text,
                                password: passwordController.text,
                              )));
                        }
                      }),
                  const Gap(30),
                  const OrDivider(),
                  const Gap(25),
                  const SocialLoginButtons(),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style:
                            getFont16TextStyle(color: AppColors.darkGreyColor),
                      ),
                      TextButton(
                          onPressed: () {
                            pushWithReplacement(
                                context, const RegisterScreen());
                          },
                          child: Text(
                            'Sign Up',
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
