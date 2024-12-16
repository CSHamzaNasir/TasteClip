import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/widgets/app_background.dart';

import 'channel_hone_controller.dart';

class ChannelHomeScreen extends StatelessWidget {
  const ChannelHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChannelHomeController());

    return AppBackground(
      isLight: true,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: AppColors.mainColor,
          backgroundColor: AppColors.lightColor,
          title: Text('Branch Name',
              style: AppTextStyles.headingStyle1
                  .copyWith(color: AppColors.textColor)),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                ),
                child: Text(
                  'Menu',
                  style: AppTextStyles.boldBodyStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: AppColors.mainColor),
                title: Text('Home', style: AppTextStyles.bodyStyle),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library, color: AppColors.mainColor),
                title: Text('Videos', style: AppTextStyles.bodyStyle),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.image, color: AppColors.mainColor),
                title: Text('Images', style: AppTextStyles.bodyStyle),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: AppColors.mainColor),
                title: Text('Settings', style: AppTextStyles.bodyStyle),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.vertical,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),

                  // SvgPicture.asset(
                  //   AppAssets.filterIcon,
                  //   height: 60,
                  // ),
                ],
              ),
              20.vertical,
              Row(
                children: List.generate(controller.labels.length, (index) {
                  return GetBuilder<ChannelHomeController>(
                    builder: (_) {
                      final isSelected = controller.selectedIndex == index;

                      return GestureDetector(
                        onTap: () => controller.updateIndex(index),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.mainColor
                                  : Colors.transparent,
                              border: Border.all(color: AppColors.mainColor),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              controller.labels[index],
                              style: AppTextStyles.bodyStyle.copyWith(
                                fontFamily: isSelected
                                    ? AppFonts.popinsMedium
                                    : AppFonts.popinsRegular,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.mainColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              20.vertical,
              Container(
                padding: EdgeInsets.all(16).copyWith(bottom: 40),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppAssets.logo,
                      height: 191,
                    ),
                    Text(
                      "Video Title",
                      style: AppTextStyles.boldBodyStyle.copyWith(
                        fontFamily: AppFonts.popinsSemiBold,
                        color: AppColors.textColor,
                      ),
                    ),
                    Text(
                      "Branch name",
                      style: AppTextStyles.lightStyle.copyWith(
                        color: AppColors.mainColor,
                      ),
                    ),
                    Text(
                      "12 min ago",
                      style: AppTextStyles.lightStyle.copyWith(
                        color: AppColors.mainColor,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
