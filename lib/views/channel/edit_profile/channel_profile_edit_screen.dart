import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/custom_appbar.dart';

import '../../../widgets/app_button.dart';
import 'channel_profile_edit_controller.dart';

class ChannelProfileEditScreen extends StatelessWidget {
  final Rx<File?> profileImage = Rx<File?>(null);
  final controller = Get.put(ChannelProfileEditController());

  ChannelProfileEditScreen({super.key});

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
                        : (controller.profileImageUrl.isNotEmpty
                            ? NetworkImage(controller.profileImageUrl.value)
                            : null),
                    child: profileImage.value == null &&
                            controller.profileImageUrl.isEmpty
                        ? const Icon(Icons.camera_alt, size: 50)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Channel Name',
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
                    controller.nameController.text,
                    profileImage.value,
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
