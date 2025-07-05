import 'package:bookia_app/core/constants/app_assets.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class EmptyWishlistWidget extends StatelessWidget {
  const EmptyWishlistWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppAssets.bookmark,
          color: AppColors.primaryColor,
          width: 80,
        ),
        const Gap(20),
        Text(
          'No books in wishlist',
          style: getFont18TextStyle(),
        ),
      ],
    ));
  }
}
