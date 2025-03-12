import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/custom_appbar.dart';

import '../../../../widgets/app_button.dart';
import 'user_profile_edit_controller.dart';

class UserProfileEditScreen extends StatelessWidget {
  final Rx<File?> profileImage = Rx<File?>(null);
  final controller = Get.put(UserProfileEditController());

  UserProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
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
                    radius: 50,
                    backgroundImage: profileImage.value != null
                        ? FileImage(profileImage.value!)
                        : (controller.profileImage.isNotEmpty
                            ? NetworkImage(controller.profileImage.value)
                            : null),
                    child: profileImage.value == null &&
                            controller.profileImage.isEmpty
                        ? const Icon(Icons.camera_alt, size: 50)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.userNameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                text: "Save",
                onPressed: () async {
                  await controller.updateProfile(
                    updatedUserName: controller.userNameController.text,
                    updatedFullName: controller.fullNameController.text,
                    imageFile: profileImage.value,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
