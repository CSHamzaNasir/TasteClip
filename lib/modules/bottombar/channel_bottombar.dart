import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/config/role_enum.dart';
import 'package:tasteclip/modules/channel/channel_home_screen.dart';

import '../../config/app_assets.dart';
import '../../core/constant/app_colors.dart';
import '../channel/profile/channel_profile_screen.dart';

class ChannelBottomBar extends StatefulWidget {
  const ChannelBottomBar({super.key});

  @override
  ChannelBottomBarState createState() => ChannelBottomBarState();
}

class ChannelBottomBarState extends State<ChannelBottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ChannelHomeScreen(),
    ChannelHomeScreen(),
    ChannelHomeScreen(),
    ChannelProfileScreen(
      role: UserRole.manager,
    ),
  ];

  final List<_BottomBarItem> _items = [
    _BottomBarItem(
      selectedSvgPath: AppAssets.homeBold,
      unselectedSvgPath: AppAssets.homeReg,
      label: 'Home',
    ),
    _BottomBarItem(
      selectedSvgPath: AppAssets.eventBold,
      unselectedSvgPath: AppAssets.categReg,
      label: 'Category',
    ),
    _BottomBarItem(
      selectedSvgPath: AppAssets.eventBold,
      unselectedSvgPath: AppAssets.eventReg,
      label: 'Event',
    ),
    _BottomBarItem(
      selectedSvgPath: AppAssets.profileBold,
      unselectedSvgPath: AppAssets.profileReg,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withCustomOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isSelected = _selectedIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.only(bottom: 4),
                        height: 4,
                        width: isSelected ? 24 : 0,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SvgPicture.asset(
                        isSelected
                            ? item.selectedSvgPath
                            : item.unselectedSvgPath,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          isSelected ? AppColors.mainColor : Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                      4.vertical,
                      if (isSelected)
                        Text(
                          item.label,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _BottomBarItem {
  final String selectedSvgPath;
  final String unselectedSvgPath;
  final String label;

  _BottomBarItem({
    required this.selectedSvgPath,
    required this.unselectedSvgPath,
    required this.label,
  });
}
