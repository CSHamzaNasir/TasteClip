import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/modules/bottombar/custom_bottom_bar.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';

import 'upload_text_feedback_controller.dart';

class PostTextFeedbackScreen extends StatelessWidget {
  final String restaurantName;
  final String branchName;

  const PostTextFeedbackScreen({
    super.key,
    required this.restaurantName,
    required this.branchName,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadTextFeedbackController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              20.vertical,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppString.describeYourThoughts,
                  style: AppTextStyles.headingStyle1.copyWith(
                    color: AppColors.mainColor,
                  ),
                ),
              ),
              16.vertical,
              const Text(
                AppString.selectResturentDes,
                style: AppTextStyles.bodyStyle,
              ),
              16.vertical,
              GetBuilder<UploadTextFeedbackController>(
                builder: (_) {
                  return Column(
                    children: [
                      AppFeild(
                        hintText: AppString.enterYourFeedbackHere,
                        controller: controller.textFeedback,
                      ),
                      16.vertical,
                      AppFeild(
                        hintText: 'Enter your rating',
                        inputType: TextInputType.number,
                        controller: controller.rating,
                      ),
                    ],
                  );
                },
              ),
              20.vertical,
              AppButton(
                isGradient: controller.textFeedback.text.isNotEmpty &&
                    controller.rating.text.isNotEmpty,
                text: 'Next',
                onPressed: controller.textFeedback.text.isNotEmpty &&
                        controller.rating.text.isNotEmpty
                    ? () {
                        controller.saveFeedback(
                          restaurantName: restaurantName,
                          branchName: branchName,
                        );
                        Get.off(CustomBottomBar());
                      }
                    : () {},
                btnColor: controller.textFeedback.text.isNotEmpty &&
                        controller.rating.text.isNotEmpty
                    ? null
                    : AppColors.greyColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
