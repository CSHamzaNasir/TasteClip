import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/views/main/channel/channel_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';

class ChannelRegisterScreen extends StatelessWidget {
  ChannelRegisterScreen({super.key});

  final controller = Get.put(ChannelController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppFeild(
                  hintText: 'restaurant name',
                  controller: controller.restaurantNameController,
                ),
                12.vertical,
                AppFeild(
                  controller: controller.branchNameController,
                  hintText: 'branch name',
                ),
                12.vertical,
                AppButton(
                  text: 'add',
                  onPressed: () {
                    controller.saveChannelData(); // Save the data to Firebase
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
