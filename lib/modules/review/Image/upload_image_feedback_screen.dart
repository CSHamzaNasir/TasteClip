import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/modules/review/upload_feedback_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';

import '../../../widgets/custom_appbar.dart';
import 'components/select_restaurant_sheet.dart';

class UploadImageFeedbackScreen extends StatelessWidget {
  UploadImageFeedbackScreen({super.key});
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              spacing: 16,
              children: [
                Image.asset(
                  AppAssets.imagebased,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${AppString.imagebasedfeedbackdesc.split(' ').take(2).join(' ')} ',
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
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: AppButton(
                    text: 'Continue',
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) =>
                            const SelectRestaurantSheetImage(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
