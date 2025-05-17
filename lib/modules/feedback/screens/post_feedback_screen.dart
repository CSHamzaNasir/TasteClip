import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/profile/controllers/user_profile_controller.dart';
import 'package:tasteclip/modules/feedback/controllers/upload_feedback_controller.dart';
import 'package:tasteclip/utils/text_shimmer.dart';
import 'package:tasteclip/widgets/app_background.dart';

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
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0)
                          .copyWith(top: 56),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Post Feedback",
                              style: AppTextStyles.regularStyle.copyWith(
                                color: AppColors.mainColor,
                                fontFamily: AppFonts.sandBold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: controller.isFormComplete.value
                                ? () async {
                                    await controller.saveFeedback(
                                      rating: controller.rating.value,
                                      restaurantName: restaurantName,
                                      branchName: branchName,
                                      description: controller.description.text,
                                      category: category,
                                      branchId: branchId,
                                    );
                                  }
                                : null,
                            child: Text(
                              "Post",
                              style: AppTextStyles.regularStyle.copyWith(
                                color: controller.isFormComplete.value
                                    ? AppColors.mainColor
                                    : AppColors.btnUnSelectColor,
                                fontFamily: AppFonts.sandBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            spacing: 16,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.btnUnSelectColor
                                        .withCustomOpacity(0.3),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withCustomOpacity(0.05),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: GetBuilder<UploadFeedbackController>(
                                  builder: (_) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          restaurantName,
                                          style: AppTextStyles.regularStyle
                                              .copyWith(
                                            fontFamily: AppFonts.sandBold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          branchName,
                                          style: AppTextStyles.regularStyle
                                              .copyWith(
                                            color: AppColors.btnUnSelectColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                        16.vertical,
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
                                                onChanged: (_) => controller
                                                    .updateFormCompleteness(
                                                        category),
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "Share your experience...",
                                                  hintStyle: TextStyle(
                                                    color: AppColors
                                                        .btnUnSelectColor
                                                        .withCustomOpacity(0.7),
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                                maxLines: 3,
                                              ),
                                            )
                                          ],
                                        ),
                                        16.vertical,
                                        Text(
                                          "Rate your experience",
                                          style: AppTextStyles.regularStyle
                                              .copyWith(
                                            fontFamily: AppFonts.sandBold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        8.vertical,
                                        GetBuilder<UploadFeedbackController>(
                                          builder: (controller) {
                                            return RatingBar.builder(
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
                                                controller.rating.value =
                                                    rating;
                                                controller
                                                    .updateFormCompleteness(
                                                        category);
                                              },
                                            );
                                          },
                                        ),
                                        16.vertical,
                                        Text(
                                          "Select food categories",
                                          style: AppTextStyles.regularStyle
                                              .copyWith(
                                            fontFamily: AppFonts.sandBold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        8.vertical,
                                        SizedBox(
                                          height: 40,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
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
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: FilterChip(
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
                                                      fontSize: 12,
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 0),
                                                  ),
                                                );
                                              });
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              20.vertical,
                              Text(
                                "Upload bill for proof (required)",
                                style: AppTextStyles.regularStyle.copyWith(
                                  fontFamily: AppFonts.sandBold,
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await controller.pickBillImage();
                                },
                                child: Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: AppColors.btnUnSelectColor
                                        .withCustomOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.btnUnSelectColor
                                          .withCustomOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Obx(
                                    () => controller.billImage.value == null
                                        ? Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.receipt_long,
                                                  color: AppColors.mainColor,
                                                  size: 32,
                                                ),
                                                8.vertical,
                                                Text(
                                                  "Tap to upload bill",
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .btnUnSelectColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.file(
                                                  controller.billImage.value!,
                                                  width: double.infinity,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                top: 8,
                                                right: 8,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.billImage.value =
                                                        null;
                                                    controller
                                                        .updateFormCompleteness(
                                                            category);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withCustomOpacity(
                                                              0.5),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (category == FeedbackCategory.image ||
                        category == FeedbackCategory.video)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withCustomOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, -4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12,
                          children: [
                            Text(
                              category == FeedbackCategory.image
                                  ? "Upload Photo"
                                  : "Upload Video",
                              style: AppTextStyles.regularStyle.copyWith(
                                fontFamily: AppFonts.sandBold,
                                fontSize: 14,
                              ),
                            ),
                            if (category == FeedbackCategory.image)
                              GestureDetector(
                                onTap: () async {
                                  await controller.pickImage();
                                },
                                child: Obx(
                                  () => Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color:
                                          controller.selectedImage.value == null
                                              ? AppColors.mainColor
                                                  .withCustomOpacity(0.1)
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: AppColors.mainColor
                                            .withCustomOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: controller.selectedImage.value ==
                                            null
                                        ? Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.camera_alt,
                                                  color: AppColors.mainColor,
                                                  size: 32,
                                                ),
                                                8.vertical,
                                                Text(
                                                  "Tap to add photo",
                                                  style: TextStyle(
                                                    color: AppColors.mainColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.file(
                                                  controller
                                                      .selectedImage.value!,
                                                  width: double.infinity,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                top: 8,
                                                right: 8,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.selectedImage
                                                        .value = null;
                                                    controller
                                                        .updateFormCompleteness(
                                                            category);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withCustomOpacity(
                                                              0.5),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                  () => Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color:
                                          controller.selectedVideo.value == null
                                              ? AppColors.mainColor
                                                  .withCustomOpacity(0.1)
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: AppColors.mainColor
                                            .withCustomOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: controller.selectedVideo.value ==
                                            null
                                        ? Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.videocam,
                                                  color: AppColors.mainColor,
                                                  size: 32,
                                                ),
                                                8.vertical,
                                                Text(
                                                  "Tap to add video",
                                                  style: TextStyle(
                                                    color: AppColors.mainColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Stack(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  color: AppColors.mainColor
                                                      .withCustomOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green,
                                                        size: 32,
                                                      ),
                                                      8.vertical,
                                                      Text(
                                                        "Video selected",
                                                        style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 8,
                                                right: 8,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.selectedVideo
                                                        .value = null;
                                                    controller
                                                        .updateFormCompleteness(
                                                            category);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withCustomOpacity(
                                                              0.5),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
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
            ),
          ),
          if (controller.isLoading.value)
            Container(
              color: Colors.black.withCustomOpacity(0.5),
              child: Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 15,
                ),
              ),
            )
        ],
      );
    });
  }
}
