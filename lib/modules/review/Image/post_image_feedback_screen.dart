import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../../../../widgets/app_feild.dart';
import '../../../widgets/app_button.dart';
import '../../bottombar/custom_bottom_bar.dart';
import 'upload_image_feedback_controller.dart';

class PostImageFeedbackScreen extends StatelessWidget {
  final String restaurantName;
  final String branchName;

  const PostImageFeedbackScreen({
    super.key,
    required this.restaurantName,
    required this.branchName,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadImageFeedbackController());

    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
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
                  GetBuilder<UploadImageFeedbackController>(
                    builder: (_) {
                      return Column(
                        spacing: 16,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await controller.pickImage();
                            },
                            child: Obx(() => Container(
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
                                      ? Icon(Icons.camera_alt,
                                          color: Colors.white)
                                      : null,
                                )),
                          ),
                          AppFeild(
                            hintText: AppString.enterYourFeedbackHere,
                            controller: controller.imageTitle,
                            feildSideClr: true,
                            hintTextColor:
                                AppColors.mainColor.withCustomOpacity(.5),
                            feildFocusClr: true,
                          ),
                          AppFeild(
                            hintText: "Description",
                            controller: controller.description,
                            feildSideClr: true,
                            hintTextColor:
                                AppColors.mainColor.withCustomOpacity(.5),
                            feildFocusClr: true,
                          ),
                          AppFeild(
                            hintText: 'Enter your rating',
                            inputType: TextInputType.number,
                            controller: controller.rating,
                            feildFocusClr: true,
                            feildSideClr: true,
                            hintTextColor:
                                AppColors.mainColor.withCustomOpacity(.3),
                          ),
                          TextField(
                            controller: controller.tagController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(12)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(12)),
                              hintText: "Add tags (Max: 15)",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  if (controller.tags.length < 15) {
                                    controller.addTag();
                                  }
                                },
                              ),
                            ),
                          ),
                          Obx(() => Wrap(
                                children: controller.tags
                                    .map(
                                      (tag) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4),
                                        child: Chip(
                                          label: Text(tag),
                                          backgroundColor: AppColors.whiteColor,
                                          elevation: 0,
                                          side: BorderSide(
                                              color: AppColors.mainColor),
                                          surfaceTintColor: AppColors.mainColor,
                                          deleteIcon: Icon(Icons.close),
                                          onDeleted: () =>
                                              controller.removeTag(tag),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              )),
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
                                      BorderSide(color: AppColors.mainColor)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(12)),
                              labelText: "Select Meal Type",
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  AppButton(
                    isGradient: controller.imageTitle.text.isNotEmpty &&
                        controller.rating.text.isNotEmpty &&
                        controller.selectedImage.value != null,
                    text: 'Next',
                    onPressed: controller.imageTitle.text.isNotEmpty &&
                            controller.rating.text.isNotEmpty &&
                            controller.selectedImage.value != null
                        ? () {
                            controller.saveFeedback(
                              imageTitle: controller.imageTitle.text,
                              rating: controller.rating.text,
                              restaurantName: restaurantName,
                              branchName: branchName,
                              description: controller.description.text,
                            );
                            Get.off(CustomBottomBar());
                          }
                        : () {},
                    btnColor: controller.imageTitle.text.isNotEmpty &&
                            controller.rating.text.isNotEmpty &&
                            controller.selectedImage.value != null
                        ? null
                        : AppColors.btnUnSelectColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
