import 'package:bookia_app/core/constants/app_assets.dart';
import 'package:bookia_app/features/home/presentation/widgets/banner_widget.dart';
import 'package:bookia_app/features/home/presentation/widgets/popular_books_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(AppAssets.logoSvg, height: 30),
        actions: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(AppAssets.notification),
          ),
          const Gap(16),
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(AppAssets.search),
          ),
          const Gap(12),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20),
            BannerWidget(),
            Gap(10),
            PopularBooksList(),
          ],
        ),
      ),
    );
  }
}
