import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_feild.dart';
import 'package:tasteclip/widgets/custom_appbar.dart';

import '../../../widgets/app_button.dart';
import 'user_profile_edit_controller.dart';

class UserProfileEditScreen extends StatelessWidget {
  final Rx<File?> profileImage = Rx<File?>(null);
  final UserProfileEditController controller =
      Get.put(UserProfileEditController());

  UserProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: Scaffold(
        appBar: CustomAppBar(title: "Edit Profile"),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final pickedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    profileImage.value = File(pickedImage.path);
                  }
                },
                child: Obx(
                  () => CircleAvatar(
                    backgroundColor:
                        AppColors.primaryColor.withCustomOpacity(.5),
                    radius: 50,
                    backgroundImage: profileImage.value != null
                        ? FileImage(profileImage.value!)
                        : (controller.profileImage.isNotEmpty
                            ? NetworkImage(controller.profileImage.value)
                            : null),
                    child: profileImage.value == null &&
                            controller.profileImage.isEmpty
                        ? Icon(Icons.account_circle_outlined,
                            size: 50,
                            color: AppColors.mainColor.withCustomOpacity(.8))
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AppFeild(
                hintText: 'Username',
                controller: controller.userNameController,
              ),
              AppFeild(
                hintText: 'Full name',
                controller: controller.fullNameController,
              ),
              const SizedBox(height: 16),
              Obx(
                () {
                  return controller.isLoading.value
                      ? SpinKitThreeBounce(
                          color: AppColors.textColor,
                          size: 25.0,
                        )
                      : AppButton(
                          text: "Save",
                          onPressed: () async {
                            if (controller.userNameController.text
                                    .trim()
                                    .isEmpty ||
                                controller.fullNameController.text
                                    .trim()
                                    .isEmpty) {
                              Get.snackbar(
                                'Missing Fields',
                                'Please fill in all required fields.',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return;
                            }

                            await controller.updateProfile(
                              updatedUserName:
                                  controller.userNameController.text.trim(),
                              updatedFullName:
                                  controller.fullNameController.text.trim(),
                              imageFile: profileImage.value,
                            );
                          });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
