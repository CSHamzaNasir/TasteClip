import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/modules/auth/splash/user_controller.dart';
import 'package:tasteclip/modules/channel/components/channel_home_appbar.dart';
import 'package:tasteclip/modules/explore/components/text_feedback_display.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';

import 'branch_detail_controller.dart';

class BranchDetailScreen extends StatelessWidget {
  final String? branchName;
  final String? branchImageUrl;

  BranchDetailScreen({
    super.key,
    this.branchName,
    this.branchImageUrl,
  });

  final UserController userController = Get.find<UserController>();
  final controller = Get.put(BranchDetailController());
  final watchFeedbackController = Get.put(WatchFeedbackController());

  @override
  Widget build(BuildContext context) {
    // Initialize with empty values if not provided
    final displayBranchName = branchName ?? "Unknown Branch";
    final displayBranchImage = branchImageUrl ?? "default_image_url";

    return AppBackground(
      isLight: true,
      child: Scaffold(
        body: Column(
          children: [
            ChannelHomeAppBar(
              image: displayBranchImage,
              username: userController.userName.value,
            ),
            16.vertical,
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.defaultImages.length,
                  (index) => GestureDetector(
                    onTap: () => controller.toggleSelection(index),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        controller.getImageForIndex(index),
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            16.vertical,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (branchName != null)
                      Text(
                        displayBranchName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    16.vertical,
                    Expanded(
                      child: TextFeedbackDisplay(
                        category: FeedbackCategory.text,
                        controller: watchFeedbackController,
                        branchName: branchName,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
