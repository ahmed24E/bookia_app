import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum DialogType {
  success,
  error,
}

showAppDialog(BuildContext context, String message,
    [DialogType? type = DialogType.error]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: type == DialogType.success
          ? AppColors.primaryColor
          : AppColors.redColor,
      content: Text(
        message,
        style: getFont16TextStyle(color: AppColors.whiteColor),
      )));
}

showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/loading.json'),
          ],
        );
      });
}
