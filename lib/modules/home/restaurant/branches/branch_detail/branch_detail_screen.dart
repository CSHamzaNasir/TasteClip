import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/channel/components/channel_home_appbar.dart';
import 'package:tasteclip/modules/explore/components/text_feedback_display.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/home/restaurant/branches/branch_detail/branch_detail_controller.dart';

class BranchDetailScreen extends StatelessWidget {
  final String? branchName;
  final String? branchImageUrl;
  BranchDetailScreen({
    super.key,
    this.branchName,
    this.branchImageUrl,
  });

  final branchDetailController = Get.put(BranchDetailController());
  final controller = Get.put(WatchFeedbackController());

  @override
  Widget build(BuildContext context) {
    final displayBranchName = branchName ?? "Unknown Branch";
    final displayBranchImage = branchImageUrl ?? "default_image_url";
    return Scaffold(
      backgroundColor: AppColors.whiteColor.withCustomOpacity(.95),
      body: Obx(() {
        if (branchDetailController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (branchDetailController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              branchDetailController.errorMessage.value,
            ),
          );
        }

        if (branchDetailController.feedbackList.isEmpty) {
          return Center(
            child: Text(
              'No feedback available',
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: branchDetailController.refreshFeedback,
          child: Column(
            children: [
              ChannelHomeAppBar(
                image: displayBranchImage,
                username: displayBranchName,
              ),
              // Obx(
              //   () => Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: List.generate(
              //       branchDetailController.defaultImages.length,
              //       (index) => GestureDetector(
              //         onTap: () =>
              //             branchDetailController.toggleSelection(index),
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: SvgPicture.asset(
              //             branchDetailController.getImageForIndex(index),
              //             width: 80,
              //             height: 80,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFeedbackDisplay(
                    branchName: displayBranchName,
                    controller: controller,
                    category: FeedbackCategory.text,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
