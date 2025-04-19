import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/modules/explore/detail/components/feedback_item.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/home/restaurant/branches/branch_detail/branch_detail_controller.dart';
import 'package:tasteclip/modules/home/restaurant/branches/components/restaurant_branch_header.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../../../../config/app_text_styles.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_fonts.dart';
import 'branches_list_controller.dart';

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        12.vertical,
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.chatbotIcon,
                              height: 40,
                            ),
                            Spacer(),
                            Text(
                              restaurantName,
                              style: AppTextStyles.boldBodyStyle.copyWith(
                                color: AppColors.textColor,
                                fontFamily: AppFonts.sandBold,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () => branchDetailController.filterIconTap(
                                  context, actionKey),
                              key: actionKey,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  AppAssets.filterSetting,
                                  fit: BoxFit.cover,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  24.vertical,
                  // In BranchesListScreen class
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

                  // In FeedbackItem widget
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Obx(() {
                        if (watchFeedbackcontroller.isLoading.value) {
                          return const Center(
                              child: CupertinoActivityIndicator());
                        }
                        return ListView.builder(
                          itemCount: watchFeedbackcontroller.feedbacks.length,
                          itemBuilder: (context, index) {
                            final feedback =
                                watchFeedbackcontroller.feedbacks[index];
                            return FeedbackItem(
                              feedback: feedback,
                              feedbackScope: FeedbackScope.branchFeedback,
                              branchId: selectedBranch.value?['branchId'] ?? '',
                            );
                          },
                        );
                      }),
                    ),
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
