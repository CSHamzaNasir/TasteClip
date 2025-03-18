import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../../../../widgets/app_feild.dart';
import '../../../widgets/app_button.dart';
import 'upload_feedback_controller.dart';

class PostImageFeedbackScreen extends StatelessWidget {
  final String restaurantName;
  final String branchName;
  final FeedbackCategory category;

  const PostImageFeedbackScreen({
    super.key,
    required this.restaurantName,
    required this.branchName,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadFeedbackController());

    return AppBackground(
      isDefault: false,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.vertical,
                  Text(
                    AppString.describeYourThoughts,
                    style: AppTextStyles.headingStyle1.copyWith(
                      color: AppColors.mainColor,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                  Text(
                    AppString.selectResturentDes,
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.mainColor,
                      fontFamily: AppFonts.sandMedium,
                    ),
                  ),
                  GetBuilder<UploadFeedbackController>(
                    builder: (_) {
                      return Column(
                        children: [
                          16.vertical,
                          if (category == FeedbackCategory.image)
                            GestureDetector(
                              onTap: () async {
                                await controller.pickImage();
                              },
                              child: Obx(
                                () => Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor
                                        .withCustomOpacity(.5),
                                    borderRadius: BorderRadius.circular(10),
                                    image:
                                        controller.selectedImage.value != null
                                            ? DecorationImage(
                                                image: FileImage(controller
                                                    .selectedImage.value!),
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                  ),
                                  child: controller.selectedImage.value == null
                                      ? Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          if (category == FeedbackCategory.video)
                            GestureDetector(
                              onTap: () async {
                                await controller.pickVideo();
                              },
                              child: Obx(
                                () => Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor
                                        .withCustomOpacity(.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: controller.selectedVideo.value == null
                                      ? Icon(
                                          Icons.videocam,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        ),
                                ),
                              ),
                            ),
                          16.vertical,
                          AppFeild(
                            hintText: "Enter your feedback",
                            controller: controller.description,
                            feildSideClr: false,
                            hintTextColor:
                                AppColors.textColor.withCustomOpacity(.3),
                            feildFocusClr: true,
                          ),
                          16.vertical,
                          AppFeild(
                            hintText: 'Enter your rating',
                            inputType: TextInputType.number,
                            controller: controller.rating,
                            feildFocusClr: true,
                            feildSideClr: false,
                            isRating: true,
                            hintTextColor:
                                AppColors.textColor.withCustomOpacity(.3),
                          ),
                          16.vertical,
                          DropdownButtonFormField<String>(
                            value: controller.selectedMealType.value,
                            items: ['Breakfast', 'Lunch', 'Dinner']
                                .map((meal) => DropdownMenuItem(
                                      value: meal,
                                      child: Text(meal),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.selectedMealType.value = value;
                              }
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: AppColors.textColor)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.textColor),
                                  borderRadius: BorderRadius.circular(12)),
                              labelText: "Select Meal Type",
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Obx(() {
                    return controller.isLoading.value
                        ? const SpinKitThreeBounce(
                            color: AppColors.textColor,
                            size: 25.0,
                          )
                        : AppButton(
                            isGradient: controller.rating.text.isNotEmpty &&
                                (category == FeedbackCategory.image
                                    ? controller.selectedImage.value != null
                                    : controller.selectedVideo.value != null),
                            text: 'Next',
                            onPressed: controller.rating.text.isNotEmpty &&
                                    (category == FeedbackCategory.image
                                        ? controller.selectedImage.value != null
                                        : controller.selectedVideo.value !=
                                            null)
                                ? () {
                                    controller.saveFeedback(
                                      rating: controller.rating.text,
                                      restaurantName: restaurantName,
                                      branchName: branchName,
                                      description: controller.description.text,
                                      category: category,
                                    );
                                  }
                                : () {},
                            btnColor: controller.rating.text.isNotEmpty &&
                                    (category == FeedbackCategory.image
                                        ? controller.selectedImage.value != null
                                        : controller.selectedVideo.value !=
                                            null)
                                ? null
                                : AppColors.btnUnSelectColor,
                          );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
