import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';

import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

import '../../../config/app_router.dart';
import '../../../config/app_text_styles.dart';
import '../user_profile_controller.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: true,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.mainColor,
          onPressed: () {
            Get.toNamed(AppRouter.uploadFeedbackScreen);
          },
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: GetBuilder<UserProfileController>(
            builder: (controller) {
              if (controller.user.value == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final userData = controller.user.value!;

              return Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Image.network(
                          'https://media.istockphoto.com/id/1364917563/photo/businessman-smiling-with-arms-crossed-on-white-background.jpg?s=612x612&w=0&k=20&c=NtM9Wbs1DBiGaiowsxJY6wNCnLf0POa65rYEwnZymrM=',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          color: AppColors.textColor.withOpacity(.50),
                        ),
                      ),
                      Positioned(
                        bottom: -30,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.primaryColor, width: 2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                width: 60,
                                height: 60,
                                'https://media.istockphoto.com/id/1364917563/photo/businessman-smiling-with-arms-crossed-on-white-background.jpg?s=612x612&w=0&k=20&c=NtM9Wbs1DBiGaiowsxJY6wNCnLf0POa65rYEwnZymrM=',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  50.vertical,
                  Text(
                    userData.fullName,
                    style: AppTextStyles.boldBodyStyle.copyWith(
                      color: AppColors.mainColor,
                    ),
                  ),
                  Text(userData.email, style: AppTextStyles.bodyStyle),
                  31.vertical,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(AppString.text,
                          style: AppTextStyles.bodyStyle
                              .copyWith(color: AppColors.mainColor)),
                      Text(AppString.images,
                          style: AppTextStyles.bodyStyle
                              .copyWith(color: AppColors.mainColor)),
                      Text(AppString.videos,
                          style: AppTextStyles.bodyStyle
                              .copyWith(color: AppColors.mainColor)),
                    ],
                  ),
                  6.vertical,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('0',
                          style: AppTextStyles.bodyStyle
                              .copyWith(color: AppColors.mainColor)),
                      Text('0',
                          style: AppTextStyles.bodyStyle
                              .copyWith(color: AppColors.mainColor)),
                      Text('0',
                          style: AppTextStyles.bodyStyle
                              .copyWith(color: AppColors.mainColor)),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
