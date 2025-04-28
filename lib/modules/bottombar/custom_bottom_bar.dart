import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/channel/event/event_screen.dart';
import 'package:tasteclip/modules/home/home_screen.dart';
import 'package:tasteclip/modules/home/restaurant/restaurant_list_screen.dart';
import 'package:tasteclip/modules/profile/user_profile_screen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex = 0;

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
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(24),
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
                                  ? AppColors.primaryColor.withCustomOpacity(.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: SvgPicture.asset(
                              height: 24,
                              width: 24,
                              fit: BoxFit.cover,
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
          ],
        ),
      ),
    );
  }
}
