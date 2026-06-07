import 'package:bookia_app/core/constants/app_fonts.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    fontFamily: AppFonts.dmSerifDisplay,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.accentColor,
      filled: true,
      hintStyle: getFont16TextStyle(color: AppColors.greyColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.redColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.redColor),
      ),
    ),
  );
}
