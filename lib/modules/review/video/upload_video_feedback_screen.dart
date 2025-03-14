import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/review/upload_feedback_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';

import '../../../widgets/custom_appbar.dart';

class UploadVideoFeedbackScreen extends StatelessWidget {
  UploadVideoFeedbackScreen({super.key});
  final controller = Get.put(UploadFeedbackController());
  @override
  Widget build(BuildContext context) {
    return AppBackground(
        isLight: true,
        child: SafeArea(
            child: Scaffold(
          appBar: const CustomAppBar(
            title: AppString.uploadfeedback,
          ),
          body: Center(
            child: Column(
              children: [
                50.vertical,
                100.horizontal,
                Text(
                  AppString.videobasedfeedback,
                  style: AppTextStyles.bodyStyle
                      .copyWith(color: AppColors.mainColor),
                ),
                20.vertical,
                Image.asset(AppAssets.video),
                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${AppString.videobasedfeedbackdesc.split(' ').take(2).join(' ')} ',
                              style: AppTextStyles.bodyStyle.copyWith(
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: AppString.videobasedfeedbackdesc
                                  .split(' ')
                                  .skip(2)
                                  .join(' '),
                              style: AppTextStyles.bodyStyle.copyWith(
                                color: AppColors.mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      41.vertical,
                      AppButton(
                        text: 'Continue',
                        onPressed: () {
                          // Your button action here
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
