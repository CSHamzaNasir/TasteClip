import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/utils/app_string.dart';

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
                  style: AppTextStyles.headingStyle.copyWith(
                    color: AppColors.mainColor,
                    fontFamily: AppFonts.sandBold,
                  ),
                ),
              ),
              16.vertical,
              Text(
                AppString.selectResturentDes,
                style: AppTextStyles.bodyStyle.copyWith(
                  color: AppColors.mainColor,
                ),
              ),
              16.vertical,
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
                                color:
                                    AppColors.mainColor.withCustomOpacity(.5),
                                borderRadius: BorderRadius.circular(10),
                                image: controller.selectedImage.value != null
                                    ? DecorationImage(
                                        image: FileImage(
                                            controller.selectedImage.value!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: controller.selectedImage.value == null
                                  ? Icon(Icons.camera_alt, color: Colors.white)
                                  : null,
                            )),
                      ),
                      AppFeild(
                        hintText: AppString.enterYourFeedbackHere,
                        controller: controller.imageTitle,
                      ),
                      AppFeild(
                        hintText: 'Enter your rating',
                        inputType: TextInputType.number,
                        controller: controller.rating,
                      ),
                    ],
                  );
                },
              ),
              20.vertical,
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
    );
  }
}
