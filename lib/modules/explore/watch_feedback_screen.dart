import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/explore/components/top_filter.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_feild.dart';

import 'components/bottom_filter.dart';
import 'components/image_feedback_display.dart' show ImageFeedbackDisplay;
import 'components/text_feedback_display.dart';
import 'watch_feedback_controller.dart';

class WatchFeedbackScreen extends StatelessWidget {
  WatchFeedbackScreen({super.key});
  final controller = Get.put(WatchFeedbackController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(right: 12),
                child: CircleAvatar(
                  radius: 16,
                ),
              )
            ],
            leading: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CircleAvatar(
                radius: 16,
              ),
            ),
            centerTitle: true,
            title: Text("Explore Feedback",
                style: AppTextStyles.bodyStyle.copyWith(
                  color: AppColors.textColor,
                  fontFamily: AppFonts.sandBold,
                )),
            backgroundColor: AppColors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Column(
              children: [
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: AppFeild(
                        feildClr: AppColors.whiteColor,
                        feildSideClr: false,
                        radius: 50,
                        hintText: "hintText",
                        prefixImage: AppAssets.search,
                        isSearchField: true,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: AppColors.btnUnSelectColor
                                  .withCustomOpacity(.5))),
                      child: SvgPicture.asset(
                        AppAssets.menuIcon,
                      ),
                    ),
                  ],
                ),
                16.vertical,
                TopFilter(controller: controller),
                Obx(() {
                  if (controller.feedbackList.isEmpty) {
                    return Center(child: CupertinoActivityIndicator());
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: controller.selectedIndex.value == 0
                              ? TextFeedbackDisplay(controller: controller)
                              : ImageFeedbackDisplay(controller: controller),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          bottomNavigationBar: BottomFilter(controller: controller),
        ),
      ),
    );
  }
}
