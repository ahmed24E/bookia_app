import 'package:bookia_app/core/constants/app_assets.dart';
import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/services/local/app_local_storage.dart';
import 'package:bookia_app/core/utils/text_styles.dart';
import 'package:bookia_app/core/widgets/nav_bar_widget.dart';
import 'package:bookia_app/features/intro/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    String? token = AppLocalStorage.getData(AppLocalStorage.token);
    Future.delayed(const Duration(seconds: 3), () {
      if (token != null) {
        pushWithReplacement(context, const NavBarWidget());
      } else {
        pushWithReplacement(context, const WelcomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.logoSvg, width: 250),
            const SizedBox(height: 10),
            Text(
              'Order Your Book Now!',
              style: getFont18TextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
