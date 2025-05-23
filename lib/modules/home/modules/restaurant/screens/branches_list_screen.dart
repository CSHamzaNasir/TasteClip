import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/modules/explore/components/feedback_item.dart';
import 'package:tasteclip/modules/explore/screens/feedback_detail_screen.dart';
import 'package:tasteclip/modules/explore/controllers/watch_feedback_controller.dart';
import 'package:tasteclip/modules/home/modules/restaurant/controllers/branch_detail_controller.dart'; 
import 'package:tasteclip/modules/home/modules/restaurant/components/restaurant_branch_header.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../controllers/branches_list_controller.dart';

class BranchesListScreen extends StatelessWidget {
  final String restaurantId;
  final String restaurantName;

  final GlobalKey actionKey = GlobalKey();

  BranchesListScreen(
      {super.key, required this.restaurantId, required this.restaurantName});

  final controller = Get.put(BranchesListController());
  final branchDetailController = Get.put(BranchDetailController());
  final watchFeedbackcontroller = Get.put(WatchFeedbackController());

  @override
  Widget build(BuildContext context) {
    final selectedBranch = Rxn<Map<String, dynamic>>();

    controller.fetchBranches(restaurantId);

    return AppBackground(
      isDefault: false,
      child: SafeArea(
        child: Scaffold(
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (controller.hasError.value) {
              return Center(child: Text("Error: ${controller.errorMessage}"));
            } else if (controller.branches.isEmpty) {
              return const Center(child: Text("No branches found."));
            } else {
              if (selectedBranch.value == null &&
                  controller.branches.isNotEmpty) {
                selectedBranch.value = controller.branches.first;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.vertical,
                  RestaurantBranchHeader(
                    controller: controller,
                    onBranchSelected: (branch) {
                      selectedBranch.value = branch;
                      if (selectedBranch.value == null &&
                          controller.branches.isNotEmpty) {
                        selectedBranch.value = controller.branches.first;
                        final initialBranchId =
                            selectedBranch.value!['branchId'];
                        watchFeedbackcontroller
                            .fetchFeedbacksForBranch(initialBranchId);
                      }
                    },
                    selectedBranchId: selectedBranch.value?['branchId'],
                  ),
                  16.vertical,
                  Expanded(
                    child: Obx(() {
                      if (watchFeedbackcontroller.isLoading.value) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ListView.builder(
                          itemCount: watchFeedbackcontroller.feedbacks.length,
                          itemBuilder: (context, index) {
                            final feedback =
                                watchFeedbackcontroller.feedbacks[index];
                            return GestureDetector(
                              onTap: () => Get.to(() => FeedbackDetailScreen(
                                    feedback: feedback,
                                    feedbackScope: FeedbackScope.allFeedback,
                                  )),
                              child: FeedbackItem(
                                feedback: feedback,
                                feedbackScope: FeedbackScope.branchFeedback,
                                branchId:
                                    selectedBranch.value?['branchId'] ?? '',
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  )
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
