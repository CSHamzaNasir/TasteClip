import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/channel/modules/event/screens/event_screen.dart';
import 'package:tasteclip/modules/feedback/screens/upload_feedback_screen.dart';
import 'package:tasteclip/modules/home/modules/restaurant/screens/restaurant_list_screen.dart';
import 'package:tasteclip/modules/home/screens/home_screen.dart';
import 'package:tasteclip/modules/profile/user_profile_screen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex = 0;
  bool _isExpanded = false;

  final List<String> _selectedIcons = [
    AppAssets.homeBold,
    AppAssets.branchBoldIcon,
    AppAssets.eventBold,
    AppAssets.profileBold,
  ];

  final List<String> _unselectedIcons = [
    AppAssets.homeReg,
    AppAssets.branchRegIcon,
    AppAssets.eventReg,
    AppAssets.profileReg,
  ];

  final List<Widget> _screens = [
    HomeScreen(),
    RestaurantListScreen(),
    AllEventsScreen(),
    UserProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            _screens[_selectedIndex],
            if (_isExpanded) ...[
              Positioned(
                bottom: 110,
                left: MediaQuery.of(context).size.width / 2 - 100,
                child: _buildCircleAction(
                    icon: AppAssets.message,
                    onTap: () {
                      Get.to(
                        UploadFeedbackScreen(category: FeedbackCategory.text),
                      );
                    }),
              ),
              Positioned(
                bottom: 150,
                left: MediaQuery.of(context).size.width / 2 - 25,
                child: _buildCircleAction(
                    icon: AppAssets.camera,
                    onTap: () {
                      Get.to(
                        UploadFeedbackScreen(category: FeedbackCategory.image),
                      );
                    }),
              ),
              Positioned(
                bottom: 110,
                left: MediaQuery.of(context).size.width / 2 + 50,
                child: _buildCircleAction(
                    icon: AppAssets.video,
                    onTap: () {
                      Get.to(
                        UploadFeedbackScreen(category: FeedbackCategory.video),
                      );
                    }),
              ),
            ],
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withCustomOpacity(0.15),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.grey.withCustomOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withCustomOpacity(0.1),
                            offset: Offset(0, 4),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: Colors.white.withCustomOpacity(0.7),
                            offset: Offset(-4, -4),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNavItem(0),
                          _buildNavItem(1),
                          _buildCenterButton(),
                          _buildNavItem(2),
                          _buildNavItem(3),
                        ],
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

  Widget _buildNavItem(int actualIndex) {
    return GestureDetector(
      onTap: () => _onItemTapped(actualIndex),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _selectedIndex == actualIndex
              ? AppColors.primaryColor.withCustomOpacity(.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          boxShadow: _selectedIndex == actualIndex
              ? [
                  BoxShadow(
                    color: AppColors.primaryColor.withCustomOpacity(0.3),
                    offset: Offset(0, 4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: SvgPicture.asset(
          height: 24,
          width: 24,
          fit: BoxFit.cover,
          _selectedIndex == actualIndex
              ? _selectedIcons[actualIndex]
              : _unselectedIcons[actualIndex],
          colorFilter: ColorFilter.mode(
            _selectedIndex == actualIndex ? AppColors.mainColor : Colors.grey,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withCustomOpacity(0.4),
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Icon(
          _isExpanded ? Icons.close : Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildCircleAction(
      {required String icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withCustomOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(
            AppColors.whiteColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
