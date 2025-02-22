import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
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
                Obx(() {
                  if (controller.feedbackList.isEmpty) {
                    return Center(child: Text("Loading..."));
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
