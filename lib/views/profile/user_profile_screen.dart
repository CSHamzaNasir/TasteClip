import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/data/repositories/auth_repository_impl.dart';
import 'package:tasteclip/widgets/app_background.dart';

import 'components/profile_notifier.dart';
import 'components/social_action_bar.dart';
import 'components/user_control.dart';
import 'user_profile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserProfileController(authRepository: AuthRepositoryImpl()));

    return AppBackground(
      isLight: true,
      child: Scaffold(
        body: GetX<UserProfileController>(
          builder: (controller) {
            if (controller.user.value == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final userData = controller.user.value!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
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
                      bottom: 70,
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
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          userData.fullName,
                          style: AppTextStyles.lightStyle.copyWith(
                            color: AppColors.lightColor,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          userData.email,
                          style: AppTextStyles.lightStyle.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                20.vertical,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SocialActionCard(),
                      16.vertical,
                      const UserControll(),
                      16.vertical,
                      const ProfileNotifier(),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
