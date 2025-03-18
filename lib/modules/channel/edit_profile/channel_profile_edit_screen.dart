import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

import '../../../config/app_text_styles.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_fonts.dart';
import 'channel_profile_edit_controller.dart';

class ChannelProfileEditScreen extends StatelessWidget {
  final controller = Get.put(ChannelProfileEditController());

  ChannelProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: Icon(
            Icons.arrow_back_ios_rounded,
            size: 18,
            color: AppColors.textColor,
          ),
          title: Text("edit",
              style: AppTextStyles.bodyStyle.copyWith(
                  color: AppColors.textColor,
                  fontFamily: AppFonts.sandMedium))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: controller.pickImage,
              child: Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.mainColor,
                    backgroundImage: controller.imageFile.value != null
                        ? FileImage(controller.imageFile.value!)
                        : null,
                    child: Icon(
                      Icons.account_circle_sharp,
                      color: AppColors.lightColor,
                      size: 50,
                    ),
                  )),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.channelNameController,
              decoration: const InputDecoration(
                labelText: "Channel Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            20.vertical,
            Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.updateBranch,
                  child: controller.isLoading.value
                      ?  CupertinoActivityIndicator(color: Colors.white)
                      : const Text("Update Branch"),
                )),
          ],
        ),
      ),
    );
  }
}
