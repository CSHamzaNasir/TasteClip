import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/modules/review/upload_feedback_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_appbar.dart';

class UploadFeedbackScreen extends StatelessWidget {
  UploadFeedbackScreen({super.key});
  final controller = Get.put(UploadFeedbackController());
  @override
  Widget build(BuildContext context) {
    return AppBackground(
        isLight: true,
        child: SafeArea(
            child: Scaffold(
                appBar: const CustomAppBar(
                  title: AppString.feedback,
                ),
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      30.vertical,
                      1000.horizontal,
                      Image.asset(AppAssets.uploadFeedback),
                      12.vertical,
                      const Text(AppString.selectyourtype,
                          style: AppTextStyles.boldStyle),
                      18.vertical,
                      Container(
                        width: 333,
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.mainColor
                            ], // Gradient colors
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(
                                          0.2), // Circle background
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        AppAssets.fileIcon,
                                        width: 20,
                                        height: 20,
                                        color: Colors.white, // Icon color
                                      ),
                                    ),
                                  ),
                                  16.horizontal,
                                  Text(
                                    AppString.textbased,
                                    style: AppTextStyles.thinStyle
                                        .copyWith(color: AppColors.lightColor),
                                  )
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      26.vertical,
                      Container(
                        width: 333,
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.mainColor
                            ], // Gradient colors
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(
                                          0.2), // Circle background
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        AppAssets.imageIcon,
                                        width: 20,
                                        height: 20,
                                        color: Colors.white, // Icon color
                                      ),
                                    ),
                                  ),
                                  16.horizontal,
                                  Text(
                                    AppString.imagebased,
                                    style: AppTextStyles.thinStyle
                                        .copyWith(color: AppColors.lightColor),
                                  )
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      25.vertical,
                      Container(
                        width: 333,
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.mainColor
                            ], // Gradient colors
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(
                                          0.2), // Circle background
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        AppAssets.videoIcon,
                                        width: 20,
                                        height: 20,
                                        color: Colors.white, // Icon color
                                      ),
                                    ),
                                  ),
                                  16.horizontal,
                                  Text(
                                    AppString.videobased,
                                    style: AppTextStyles.thinStyle
                                        .copyWith(color: AppColors.lightColor),
                                  )
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]))));
  }
}
