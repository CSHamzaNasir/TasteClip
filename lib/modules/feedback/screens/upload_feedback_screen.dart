import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/feedback/controllers/upload_feedback_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: category == FeedbackCategory.image
                ? AppString.uploadfeedback
                : category == FeedbackCategory.video
                    ? "Upload Video Feedback"
                    : "Upload Text Feedback",
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppAssets.imagebased,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: category == FeedbackCategory.image
                                ? 'Image '
                                : category == FeedbackCategory.video
                                    ? 'Video '
                                    : 'Text ',
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: AppString.imagebasedfeedbackdesc
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
                  ),
                ),
                const SizedBox(height: 24),
                AppButton(
                  text: 'Continue',
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) =>
                          SelectRestaurantSheetImage(category: category),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
