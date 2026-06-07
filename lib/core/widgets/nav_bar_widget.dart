import 'package:bookia_app/core/constants/app_assets.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/features/cart/presentation/page/cart_screen.dart';
import 'package:bookia_app/features/home/presentation/page/home_screen.dart';
import 'package:bookia_app/features/profile/presentation/page/profile_view.dart';
import 'package:bookia_app/features/wishlist/presentation/page/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key, this.preIndex});
  final int? preIndex;

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    currentPage = widget.preIndex ?? 0;
  }

  List<Widget> pages = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.whiteColor,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.darkColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppAssets.home,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn),
                  // color: AppColors.primaryColor,
                ),
                icon: SvgPicture.asset(AppAssets.home),
                label: 'Home'),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppAssets.bookmark,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn),
                ),
                icon: SvgPicture.asset(AppAssets.bookmark),
                label: 'Search'),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppAssets.cart,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn),
                ),
                icon: SvgPicture.asset(AppAssets.cart),
                label: 'Cart'),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppAssets.profile,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn),
                ),
                icon: SvgPicture.asset(AppAssets.profile),
                label: 'Profile'),
          ]),
    );
  }
}
