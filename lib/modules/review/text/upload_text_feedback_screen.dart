import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/review/Image/upload_feedback_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';

import '../../../widgets/custom_appbar.dart';
import 'components/select_restaurant_sheet.dart';

class UploadTextFeedbackScreen extends StatelessWidget {
  UploadTextFeedbackScreen({super.key});
  final controller = Get.put(UploadFeedbackController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(
            title: "Upload Text Feedback",
            showBackIcon: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(AppAssets.textbased),
                      Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${AppString.textbasedfeedbackdesc.split(' ').take(2).join(' ')} ',
                                    style: AppTextStyles.boldBodyStyle.copyWith(
                                      color: AppColors.mainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: AppString.textbasedfeedbackdesc
                                        .split(' ')
                                        .skip(2)
                                        .join(' '),
                                    style: AppTextStyles.lightStyle.copyWith(
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            38.vertical,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppButton(
                  text: 'Continue',
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const SelectRestaurantSheetText(),
                    );
                  },
                ),
              ),
              30.vertical,
            ],
          ),
        ),
      ),
    );
  }
}
