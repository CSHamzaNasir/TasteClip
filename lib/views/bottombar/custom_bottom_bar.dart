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
      _showBottomSheet();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose an option",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomSheetIcon(
                    iconPath: AppAssets.message,
                    label: "Text",
                    onTap: () {
                      Get.toNamed(AppRouter.uploadTextFeedbackScreen);
                    },
                  ),
                  _buildBottomSheetIcon(
                    iconPath: AppAssets.camera,
                    label: "Image",
                    onTap: () {
                      Get.toNamed(AppRouter.uploadImageFeedbackScreen);
                    },
                  ),
                  _buildBottomSheetIcon(
                    iconPath: AppAssets.video,
                    label: "Video",
                    onTap: () {
                      // Add action for video
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetIcon(
      {required String iconPath,
      required String label,
      required VoidCallback onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: SvgPicture.asset(
              iconPath,
              width: 30,
              height: 30,
              colorFilter:
                  ColorFilter.mode(AppColors.mainColor, BlendMode.srcIn),
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
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
