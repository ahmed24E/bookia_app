import 'package:bookia_app/core/constants/app_assets.dart';
import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/utils/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_button.dart';
import 'package:bookia_app/core/widgets/outline_button.dart';
import 'package:bookia_app/features/auth/presentation/page/login_screen.dart';
import 'package:bookia_app/features/auth/presentation/page/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'assets/images/welcome_bg.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 2,
              ),
              SvgPicture.asset(AppAssets.logoSvg, width: 250),
              const SizedBox(height: 10),
              Text(
                'Order Your Book Now!',
                style: getFont18TextStyle(),
              ),
              const Spacer(
                flex: 5,
              ),
              CustomButton(
                text: 'Login',
                onPressed: () {
                  pushTo(context, const LoginScreen());
                },
              ),
              const Gap(15),
              CustomOutlineButton(
                text: 'Register',
                onPressed: () {
                  pushTo(context, const RegisterScreen());
                },
              ),
              const Spacer(),
            ],
          ),
        )
      ],
    ));
  }
}
