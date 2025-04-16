import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/home/restaurant/branches/branch_detail/branch_detail_controller.dart';

class BranchDetailScreen extends StatelessWidget {
  final String? branchName;
  final String? branchImageUrl;

  final GlobalKey actionKey = GlobalKey();

  BranchDetailScreen({
    super.key,
    this.branchName,
    this.branchImageUrl,
  });

  final branchDetailController = Get.put(BranchDetailController());
  final controller = Get.put(WatchFeedbackController());

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final displayBranchName = branchName ?? "Unknown Branch";
    return Scaffold(
      backgroundColor: AppColors.whiteColor.withCustomOpacity(.95),
      body: Obx(() {
        if (branchDetailController.isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
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
              16.vertical,
              // Expanded(
              //   child: Padding(
              //       padding: EdgeInsets.symmetric(
              //           horizontal:
              //               branchDetailController.selectedCategory.value ==
              //                       FeedbackCategory.text
              //                   ? 20.0
              //                   : 4),
              //       child: branchDetailController.selectedCategory.value ==
              //               FeedbackCategory.text
              //           ? TextFeedbackDisplay(
              //               branchName: displayBranchName,
              //               category: FeedbackCategory.text,
              //               feedback: FeedbackScope.branchFeedback,
              //             )
              //           : ImageFeedbackDisplay(
              //               category: FeedbackCategory.image,
              //             )),
              // )
            ],
          ),
        );
      }),
    );
  }
}
