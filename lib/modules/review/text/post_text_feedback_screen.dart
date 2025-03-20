import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
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
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: AppColors.mainColor,
                        ),
                        onRatingUpdate: (rating) {
                          controller.rating.value = rating;
                        },
                      ),
                      16.vertical,
                    ],
                  );
                },
              ),
              20.vertical,
              Obx(() {
                return controller.isLoading.value
                    ? const SpinKitThreeBounce(
                        color: AppColors.textColor,
                        size: 25.0,
                      )
                    : AppButton(
                        isGradient: controller.textFeedback.text.isNotEmpty &&
                            controller.rating.value > 0,
                        text: 'Next',
                        onPressed: controller.textFeedback.text.isNotEmpty &&
                                controller.rating.value > 0
                            ? () {
                                controller.saveFeedback(
                                  restaurantName: restaurantName,
                                  branchName: branchName,
                                  rating: controller.rating.value.toString(),
                                  textFeedback: controller.textFeedback.text,
                                );
                              }
                            : () {},
                        btnColor: controller.textFeedback.text.isNotEmpty &&
                                controller.rating.value > 0
                            ? null
                            : AppColors.btnUnSelectColor,
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
