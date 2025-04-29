import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/channel/channel_home_controller.dart';
import 'package:tasteclip/modules/channel/components/channel_top_widget.dart';
import 'package:tasteclip/modules/explore/detail/components/feedback_item.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
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
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  final address = channelHomeController
                          .managerData.value?['branchAddress'] ??
                      'Loading...';
                  return Row(
                    children: [
                      SvgPicture.asset(
                        fit: BoxFit.cover,
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                          AppColors.mainColor,
                          BlendMode.srcIn,
                        ),
                        AppAssets.branchIcon,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          address,
                          style: AppTextStyles.bodyStyle.copyWith(
                            color: AppColors.mainColor,
                            fontFamily: AppFonts.sandBold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ChannelTopWidget(
                      title: 'Voucher',
                      icon: AppAssets.voucherIcon,
                    ),
                    ChannelTopWidget(
                      title: '   Event   ',
                      icon: AppAssets.eventBold,
                    ),
                    ChannelTopWidget(
                      title: 'Voucher',
                      icon: AppAssets.voucherIcon,
                    )
                  ],
                ),
                Expanded(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
