import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/channel/components/channel_home_appbar.dart';
import 'package:tasteclip/modules/channel/components/channel_top_widget.dart';
import 'package:tasteclip/modules/channel/components/feedback_count.dart';
import 'package:tasteclip/modules/channel/controllers/channel_home_controller.dart';
import 'package:tasteclip/modules/channel/modules/event/screens/create_event_screen.dart';
import 'package:tasteclip/modules/channel/modules/report/screens/manager_report_screen.dart';
import 'package:tasteclip/modules/channel/screens/add_bill_screen.dart';
import 'package:tasteclip/modules/explore/components/feedback_item.dart';
import 'package:tasteclip/modules/explore/controllers/watch_feedback_controller.dart';
import 'package:tasteclip/modules/explore/screens/feedback_detail_screen.dart';
import 'package:tasteclip/modules/redeem/model/create_voucher_screen.dart';
import 'package:tasteclip/widgets/app_background.dart';

class ChannelHomeScreen extends StatelessWidget {
  ChannelHomeScreen({super.key});
  final watchFeedbackcontroller = Get.put(WatchFeedbackController());
  final channelHomeController = Get.put(ChannelHomeController());
  Map<String, int> getFeedbackCounts() {
    return watchFeedbackcontroller.getFeedbackCountsByBranch(
      channelHomeController.branchId,
    );
  }

  void _openFeedbackBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Feedback Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            FeedbackCountItem(
              icon: AppAssets.message,
              label: 'Text Feedback',
              count: channelHomeController.textFeedbackCount.value,
            ),
            FeedbackCountItem(
              icon: AppAssets.camera,
              label: 'Image Feedback',
              count: channelHomeController.imageFeedbackCount.value,
            ),
            FeedbackCountItem(
              icon: AppAssets.video,
              label: 'Video Feedback',
              count: channelHomeController.videoFeedbackCount.value,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    log((channelHomeController.textFeedbackCount.value +
            channelHomeController.imageFeedbackCount.value +
            channelHomeController.videoFeedbackCount.value)
        .toString());
    log(channelHomeController.branchId);
    return AppBackground(
      isDefault: false,
      child: Scaffold(
        body: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => ChannelHomeAppBar(
                onActionTap: channelHomeController.logout,
                image: channelHomeController
                        .managerData.value?['branchThumbnail'] ??
                    '',
                username:
                    channelHomeController.managerData.value?['branchAddress'] ??
                        '')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ChannelTopWidget(
                  title: 'Voucher',
                  icon: AppAssets.voucherIcon,
                  count: null,
                  onTap: () {
                    Get.to(() => CreateVoucherScreen());
                  },
                ),
                ChannelTopWidget(
                  title: 'Event',
                  icon: AppAssets.eventBold,
                  count: null,
                  onTap: () {
                    Get.to(() => CreateEventScreen());
                  },
                ),
                ChannelTopWidget(
                  title: 'Bill',
                  icon: AppAssets.billIcon,
                  count: null,
                  onTap: () {
                    Get.to(() => UpdateBranchBillScreen());
                  },
                ),
                Obx(
                  () => ChannelTopWidget(
                    title: 'Feedback',
                    icon: AppAssets.branchIcon,
                    count: channelHomeController.textFeedbackCount.value +
                        channelHomeController.imageFeedbackCount.value +
                        channelHomeController.videoFeedbackCount.value,
                    onTap: () {
                      _openFeedbackBottomSheet(context);
                    },
                  ),
                ),
                ChannelTopWidget(
                  title: 'Support',
                  icon: AppAssets.supportIcon,
                  count: null,
                  onTap: () {
                    Get.to(() => ManagerReportsScreen());
                  },
                ),
              ],
            ),
            Obx(() {
              if (channelHomeController.textFeedbackCount.value +
                      channelHomeController.imageFeedbackCount.value +
                      channelHomeController.videoFeedbackCount.value ==
                  0) {
                return Center(
                  child: Column(
                    spacing: 16,
                    children: [
                      100.vertical,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SvgPicture.asset(
                          height: 150,
                          AppAssets.nofeedbackFound,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "No Feedback found!",
                        style: AppTextStyles.bodyStyle.copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListView.builder(
                      itemCount: watchFeedbackcontroller.feedbacks.length,
                      itemBuilder: (context, index) {
                        final feedback =
                            watchFeedbackcontroller.feedbacks[index];
                        return GestureDetector(
                          onTap: () => Get.to(() => FeedbackDetailScreen(
                                userRole: UserRole.manager,
                                feedback: feedback,
                                feedbackScope: FeedbackScope.allFeedback,
                              )),
                          child: FeedbackItem(
                            feedback: feedback,
                            feedbackScope: FeedbackScope.branchFeedback,
                            branchId: channelHomeController.branchId,
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
