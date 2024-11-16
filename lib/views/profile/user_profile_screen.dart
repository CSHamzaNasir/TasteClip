import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  PlatformFile? pickedFile;

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future<void> uploadFile() async {
    if (pickedFile?.path == null) {
      if (kDebugMode) {
        print("No file selected.");
      }
      return;
    }

    try {
      final file = File(pickedFile!.path!);
      final path = 'user_images/${pickedFile!.name}';

      final ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file);

      // Optionally, handle success feedback
      if (kDebugMode) {
        print("Upload successful: ${pickedFile!.name}");
      }
    } catch (e) {
      // Error handling
      if (kDebugMode) {
        print("Error uploading file: $e");
      }
    }
  }

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
                    ElevatedButton(
                        onPressed: uploadFile, child: const Text('upload')),
                    Positioned(
                      top: 35,
                      right: 22,
                      child: InkWell(
                        onTap: () {
                          selectFile();
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
                  ],
                ),
                20.vertical,
                if (pickedFile != null)
                  Expanded(
                    child: Container(
                      color: Colors.amber,
                      child: Center(
                        child: Text(pickedFile!.name),
                      ),
                    ),
                  ),
                if (pickedFile != null)
                  Expanded(
                    child: Container(
                      color: Colors.amber,
                      child: Image.file(
                        File(pickedFile!.path!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
