import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/views/main/home/home_screen.dart';
import 'package:tasteclip/views/main/profile/user_profile_screen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex = 0;

  final List<String> _selectedIcons = [
    AppAssets.homeBold,
    AppAssets.addBold,
    AppAssets.camera,
    AppAssets.profileBold,
  ];

  final List<String> _unselectedIcons = [
    AppAssets.homeReg,
    AppAssets.addIcon,
    AppAssets.camera,
    AppAssets.profileReg,
  ];

  final List<Widget> _screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    UserProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      _showSvgDialog();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showSvgDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.17,
              padding: EdgeInsets.only(top: 60),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
            Positioned(
              top: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () =>
                          Get.toNamed(AppRouter.uploadTextFeedbackScreen),
                      child: _buildSvgIcon(AppAssets.message)),
                  10.horizontal,
                  _buildSvgIcon(AppAssets.camera),
                  10.horizontal,
                  _buildSvgIcon(AppAssets.video),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSvgIcon(String assetPath) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 5),
        ],
      ),
      child: SvgPicture.asset(
        assetPath,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(AppColors.mainColor, BlendMode.srcIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            _screens[_selectedIndex],
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff9D9D9D).withCustomOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          _selectedIcons.length,
                          (index) => GestureDetector(
                            onTap: () => _onItemTapped(index),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: _selectedIndex == index
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: SvgPicture.asset(
                                _selectedIndex == index
                                    ? _selectedIcons[index]
                                    : _unselectedIcons[index],
                                colorFilter: ColorFilter.mode(
                                  _selectedIndex == index
                                      ? AppColors.mainColor
                                      : Colors.grey,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
