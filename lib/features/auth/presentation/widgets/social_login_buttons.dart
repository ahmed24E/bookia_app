import 'package:bookia_app/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset('assets/images/google.svg'),
          ),
        ),
        const Gap(10),
        Expanded(
          child: Container(
            height: 56,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset('assets/images/facebook.svg'),
          ),
        ),
        const Gap(10),
        Expanded(
          child: Container(
            height: 56,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset('assets/images/apple.svg'),
          ),
        )
      ],
    );
  }
}
