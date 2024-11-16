import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/views/profile/components/profile_notifier.dart';
import 'package:tasteclip/widgets/app_background.dart';
import '../../data/repositories/auth_repository_impl.dart';
import 'components/social_action_bar.dart';
import 'components/user_control.dart';
import 'user_profile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: Scaffold(
        body: GetBuilder<UserProfileController>(
          init: UserProfileController(authRepository: AuthRepositoryImpl()),
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
                      child: controller.user.value!.profileImageUrl != null
                          ? Image.network(
                              controller.user.value!.profileImageUrl!,
                              height: 250,
                              width: double.infinity,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return SizedBox(
                                    height: 250,
                                    width: double.infinity,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.lightColor,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.account_circle, size: 60),
                            )
                          : const Icon(
                              Icons.account_circle,
                              size: 60,
                              color: AppColors.lightColor,
                            ),
                    ),
                    Positioned.fill(
                      child: Container(
                        color: AppColors.textColor.withOpacity(.50),
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
                            child: controller.pickedFile != null
                                ? Image.file(
                                    File(controller.pickedFile!.path!),
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  )
                                : controller.user.value!.profileImageUrl != null
                                    ? Image.network(
                                        controller.user.value!.profileImageUrl!,
                                        height: 60,
                                        width: 60,
                                      )
                                    : const Icon(
                                        Icons.account_circle,
                                        size: 60,
                                        color: AppColors.lightColor,
                                      ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 35,
                      right: 22,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Add Profile Image"),
                              content: SizedBox(
                                height: 150,
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Obx(() {
                                        if (controller.isLoading.value) {
                                          return const CircularProgressIndicator(
                                            strokeWidth: 1,
                                            color: AppColors.primaryColor,
                                          );
                                        }
                                        return controller.pickedFile != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.file(
                                                  File(controller
                                                      .pickedFile!.path!),
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : Icon(
                                                Icons.account_circle,
                                                color: AppColors.mainColor,
                                                size: 100,
                                              );
                                      }),
                                      Positioned(
                                        bottom: 2,
                                        right: 5,
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: AppColors.lightColor,
                                          ),
                                          child: IconButton(
                                            onPressed: controller.selectFile,
                                            icon: Icon(
                                              Icons.camera_alt,
                                              color: AppColors.mainColor,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                if (controller.pickedFile != null)
                                  TextButton(
                                    onPressed: () {
                                      controller.uploadFile();
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text('Upload'),
                                  ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: AppColors.lightColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 35,
                        left: 4,
                        child: InkWell(
                          onTap: controller.goToHomeScreen,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.lightColor,
                                borderRadius: BorderRadius.circular(6)),
                            height: 30,
                            width: 120,
                            child: Row(
                              children: [
                                Icon(Icons.arrow_left),
                                Text(AppString.backToHome,
                                    style: AppTextStyles.lightStyle
                                        .copyWith(color: AppColors.mainColor))
                              ],
                            ),
                          ),
                        ))
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
                      ProfileNotifier()
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
