import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/modules/channel/channel_home_controller.dart';
import 'package:tasteclip/modules/channel/components/channel_home_appbar.dart';
import 'package:tasteclip/modules/channel/components/channel_top_widget.dart';
import 'package:tasteclip/modules/explore/detail/components/feedback_item.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/redeem/model/create_voucher_screen.dart';
import 'package:tasteclip/widgets/app_background.dart';

class ChannelHomeScreen extends StatelessWidget {
  ChannelHomeScreen({super.key});
  final watchFeedbackcontroller = Get.put(WatchFeedbackController());
  final channelHomeController = Get.put(ChannelHomeController());

  @override
  Widget build(BuildContext context) {
    log(channelHomeController.branchId);
    return AppBackground(
      isDefault: false,
      child: Scaffold(
        body: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChannelHomeAppBar(
                onActionTap: channelHomeController.logout,
                image: channelHomeController
                        .managerData.value?['branchThumbnail'] ??
                    '',
                username:
                    channelHomeController.managerData.value?['branchAddress'] ??
                        ''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ChannelTopWidget(
                  title: 'Voucher',
                  icon: AppAssets.voucherIcon,
                  onTap: () {
                    Get.to(() => CreateVoucherScreen());
                  },
                ),
                ChannelTopWidget(
                  title: '   Event   ',
                  icon: AppAssets.eventBold,
                  onTap: () {
                    Get.to(() => CreateVoucherScreen());
                  },
                ),
                ChannelTopWidget(
                  title: 'Voucher',
                  icon: AppAssets.voucherIcon,
                  onTap: () {
                    Get.to(() => CreateVoucherScreen());
                  },
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.builder(
                  itemCount: watchFeedbackcontroller.feedbacks.length,
                  itemBuilder: (context, index) {
                    final feedback = watchFeedbackcontroller.feedbacks[index];
                    return FeedbackItem(
                      feedback: feedback,
                      feedbackScope: FeedbackScope.branchFeedback,
                      branchId: channelHomeController.branchId,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
