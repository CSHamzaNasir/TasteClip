import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';

import 'upload_feedback_controller.dart';

class PostFeedbackScreen extends StatelessWidget {
  final String restaurantName;
  final String branchName;
  final String branchId;
  final FeedbackCategory category;

  const PostFeedbackScreen({
    super.key,
    required this.restaurantName,
    required this.branchName,
    required this.category,
    required this.branchId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadFeedbackController());

    return AppBackground(
      isDefault: false,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                16.vertical,
                                if (category == FeedbackCategory.image)
                                  Center(
                                    child: GestureDetector(
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: controller
                                                        .selectedImage.value !=
                                                    null
                                                ? DecorationImage(
                                                    image: FileImage(controller
                                                        .selectedImage.value!),
                                                    fit: BoxFit.cover,
                                                  )
                                                : null,
                                          ),
                                          child:
                                              controller.selectedImage.value ==
                                                      null
                                                  ? Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.white,
                                                    )
                                                  : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (category == FeedbackCategory.video)
                                  Center(
                                    child: GestureDetector(
                                      onTap: () async {
                                        await controller
                                            .showVideoSourceChoice();
                                      },
                                      child: Obx(
                                        () => Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: AppColors.mainColor
                                                .withCustomOpacity(.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child:
                                              controller.selectedVideo.value ==
                                                      null
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
                                Text(
                                  "Select Hashtags",
                                  style: AppTextStyles.bodyStyle.copyWith(
                                    color: AppColors.mainColor,
                                    fontFamily: AppFonts.sandMedium,
                                  ),
                                ),
                                8.vertical,
                                Wrap(
                                  spacing: 4,
                                  runSpacing: 0,
                                  children: [
                                    'Fast Food',
                                    'Pizza',
                                    'Chicken Dishes',
                                    'Noodles or Pasta',
                                    'Rice Meals',
                                    'BBQ/Grill',
                                    'Seafood',
                                    'Wraps and Tacos',
                                    'Bakery and Snacks',
                                    'Desserts',
                                    'Others'
                                  ].map((hashtag) {
                                    return Obx(() {
                                      final isSelected = controller
                                          .selectedHashtags
                                          .contains(hashtag);
                                      return FilterChip(
                                        label: Text('#$hashtag'),
                                        selected: isSelected,
                                        onSelected: (selected) {
                                          if (selected) {
                                            controller.selectedHashtags
                                                .add(hashtag);
                                          } else {
                                            controller.selectedHashtags
                                                .remove(hashtag);
                                          }
                                        },
                                        selectedColor: AppColors.mainColor,
                                        checkmarkColor: Colors.white,
                                        labelStyle: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : AppColors.mainColor,
                                        ),
                                      );
                                    });
                                  }).toList(),
                                ),
                                16.vertical,
                                RatingBar.builder(
                                  initialRating: controller.rating.value,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 30,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: AppColors.mainColor,
                                  ),
                                  onRatingUpdate: (rating) {
                                    controller.rating.value = rating;
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(() {
                bool isFormValid = controller.rating.value > 0 &&
                    controller.description.text.isNotEmpty;

                if (category == FeedbackCategory.image) {
                  isFormValid =
                      isFormValid && controller.selectedImage.value != null;
                } else if (category == FeedbackCategory.video) {
                  isFormValid =
                      isFormValid && controller.selectedVideo.value != null;
                }

                return controller.isLoading.value
                    ? const SpinKitThreeBounce(
                        color: AppColors.textColor,
                        size: 25.0,
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 6),
                        child: AppButton(
                          text: 'Submit',
                          onPressed: () => controller.saveFeedback(
                            rating: controller.rating.value,
                            restaurantName: restaurantName,
                            branchName: branchName,
                            description: controller.description.text,
                            category: category,
                            branchId: branchId,
                          ),
                          btnColor:
                              isFormValid ? null : AppColors.btnUnSelectColor,
                        ),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
