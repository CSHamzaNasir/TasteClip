import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/feedback/controllers/upload_feedback_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../../../widgets/custom_appbar.dart';
import '../components/select_restaurant_sheet.dart';

class UploadFeedbackScreen extends StatelessWidget {
  final FeedbackCategory category;
  final UploadFeedbackController controller =
      Get.put(UploadFeedbackController());

  UploadFeedbackScreen({
    super.key,
    required this.category,
  });

  String get _getCategoryTitle {
    switch (category) {
      case FeedbackCategory.image:
        return AppString.uploadfeedback;
      case FeedbackCategory.video:
        return "Upload Video Feedback";
      default:
        return "Upload Text Feedback";
    }
  }

  String get _getCategoryText {
    switch (category) {
      case FeedbackCategory.image:
        return 'Image';
      case FeedbackCategory.video:
        return 'Video';
      default:
        return 'Text';
    }
  }

  IconData get _getCategoryIcon {
    switch (category) {
      case FeedbackCategory.image:
        return Icons.image_outlined;
      case FeedbackCategory.video:
        return Icons.videocam_outlined;
      default:
        return Icons.text_fields_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.lightColor,
          appBar: CustomAppBar(
            title: _getCategoryTitle,
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryColor.withCustomOpacity(0.1),
                      AppColors.lightColor,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.primaryColor.withCustomOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Icon(
                          _getCategoryIcon,
                          size: 40,
                          color: AppColors.mainColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '$_getCategoryText Feedback',
                        style: AppTextStyles.bodyStyle.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyColor.withCustomOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            AppAssets.imagebased,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  AppColors.primaryColor.withCustomOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.info_outline,
                                        size: 20,
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'How it works',
                                      style: AppTextStyles.bodyStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '$_getCategoryText ',
                                        style: AppTextStyles.bodyStyle.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppString.imagebasedfeedbackdesc
                                            .split(' ')
                                            .skip(2)
                                            .join(' '),
                                        style: AppTextStyles.bodyStyle.copyWith(
                                          color: AppColors.textColor,
                                          fontSize: 16,
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                _buildFeatureItem(
                                  icon: Icons.restaurant_outlined,
                                  text: 'Select your restaurant',
                                ),
                                const SizedBox(height: 12),
                                _buildFeatureItem(
                                  icon: Icons.upload_outlined,
                                  text:
                                      'Upload your ${_getCategoryText.toLowerCase()}',
                                ),
                                const SizedBox(height: 12),
                                _buildFeatureItem(
                                  icon: Icons.star_outline,
                                  text: 'Share your experience',
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
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyColor.withCustomOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.mainColor,
                            AppColors.primaryColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.mainColor.withCustomOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => SelectRestaurantSheetImage(
                                  category: category),
                            );
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Continue',
                                  style: AppTextStyles.bodyStyle.copyWith(
                                    color: AppColors.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: AppColors.whiteColor,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ready to share your feedback?',
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.btnUnSelectColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withCustomOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 16,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyStyle.copyWith(
              color: AppColors.textColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
