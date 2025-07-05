import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Text('   Or Login with   ',
            style: getFont14TextStyle(color: AppColors.darkGreyColor)),
        const Expanded(child: Divider()),
      ],
    );
  }
}
