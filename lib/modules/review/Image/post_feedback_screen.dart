import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/profile/user_profile_controller.dart';
import 'package:tasteclip/utils/text_shimmer.dart';
import 'package:tasteclip/widgets/app_background.dart';

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
    final profileController = Get.put(UserProfileController());

    return Obx(() {
      return Stack(
        children: [
          AppBackground(
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Text(
                                        "Cancel",
                                        style:
                                            AppTextStyles.regularStyle.copyWith(
                                          color: AppColors.btnUnSelectColor,
                                          fontFamily: AppFonts.sandBold,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (controller.rating.value > 0 &&
                                            controller
                                                .description.text.isNotEmpty) {
                                          if (category ==
                                                  FeedbackCategory.image &&
                                              controller.selectedImage.value ==
                                                  null) {
                                            Get.snackbar('Error',
                                                'Please select an image');
                                            return;
                                          }
                                          if (category ==
                                                  FeedbackCategory.video &&
                                              controller.selectedVideo.value ==
                                                  null) {
                                            Get.snackbar('Error',
                                                'Please select a video');
                                            return;
                                          }

                                          await controller.saveFeedback(
                                            rating: controller.rating.value,
                                            restaurantName: restaurantName,
                                            branchName: branchName,
                                            description:
                                                controller.description.text,
                                            category: category,
                                            branchId: branchId,
                                          );
                                        } else {
                                          Get.snackbar('Error',
                                              'Please fill all required fields');
                                        }
                                      },
                                      child: Text(
                                        "Post",
                                        style:
                                            AppTextStyles.regularStyle.copyWith(
                                          color: controller.rating.value > 0 &&
                                                  controller.description.text
                                                      .isNotEmpty &&
                                                  (category ==
                                                          FeedbackCategory
                                                              .text ||
                                                      (category ==
                                                              FeedbackCategory
                                                                  .image &&
                                                          controller
                                                                  .selectedImage
                                                                  .value !=
                                                              null) ||
                                                      (category ==
                                                              FeedbackCategory
                                                                  .video &&
                                                          controller
                                                                  .selectedVideo
                                                                  .value !=
                                                              null))
                                              ? AppColors.mainColor
                                              : AppColors.btnUnSelectColor,
                                          fontFamily: AppFonts.sandBold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: AppColors.btnUnSelectColor,
                                      )),
                                  child: GetBuilder<UploadFeedbackController>(
                                    builder: (_) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            spacing: 12,
                                            children: [
                                              Obx(
                                                () => ProfileImageWithShimmer(
                                                  imageUrl: profileController
                                                      .profileImage.value,
                                                ),
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  controller:
                                                      controller.description,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "Enter your feedback"),
                                                ),
                                              )
                                            ],
                                          ),
                                          8.vertical,
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              spacing: 8,
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
                                                'Desserts'
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
                                                        controller
                                                            .selectedHashtags
                                                            .add(hashtag);
                                                      } else {
                                                        controller
                                                            .selectedHashtags
                                                            .remove(hashtag);
                                                      }
                                                    },
                                                    selectedColor:
                                                        AppColors.mainColor,
                                                    checkmarkColor:
                                                        Colors.white,
                                                    labelStyle: TextStyle(
                                                      color: isSelected
                                                          ? Colors.white
                                                          : AppColors.mainColor,
                                                    ),
                                                  );
                                                });
                                              }).toList(),
                                            ),
                                          ),
                                          16.vertical,
                                          RatingBar.builder(
                                            initialRating:
                                                controller.rating.value,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16),
                        child: Column(
                          spacing: 8,
                          children: [
                            if (category == FeedbackCategory.image)
                              GestureDetector(
                                onTap: () async {
                                  await controller.pickImage();
                                },
                                child: Obx(
                                  () => Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: AppColors.mainColor
                                            .withCustomOpacity(.5),
                                        borderRadius: BorderRadius.circular(10),
                                        image: controller.selectedImage.value !=
                                                null
                                            ? DecorationImage(
                                                image: FileImage(controller
                                                    .selectedImage.value!),
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                      ),
                                      child:
                                          controller.selectedImage.value == null
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
                              GestureDetector(
                                onTap: () async {
                                  await controller.showVideoSourceChoice();
                                },
                                child: Obx(
                                  () => Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: AppColors.mainColor
                                            .withCustomOpacity(.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child:
                                          controller.selectedVideo.value == null
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          if (controller.isLoading.value)
            Container(
              color: Colors.black.withCustomOpacity(0.5),
              child: Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.whiteColor,
                ),
              ),
            )
        ],
      );
    });
  }
}
