import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/modules/auth/splash/user_controller.dart';
import 'package:tasteclip/modules/channel/components/channel_home_appbar.dart';
import 'package:tasteclip/widgets/app_background.dart';

import 'branch_detail_controller.dart';

class BranchDetailScreen extends StatelessWidget {
  final String branchName;
  final String branchImageUrl;

  BranchDetailScreen({
    super.key,
    required this.branchName,
    required this.branchImageUrl,
  });

  final UserController userController = Get.find<UserController>();
  final BranchDetailController branchDetailController =
      Get.put(BranchDetailController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: Scaffold(
        body: Column(
          children: [
            ChannelHomeAppBar(
              image: branchImageUrl,
              username: userController.userName.value,
            ),
            16.vertical,
            Obx(() => Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          branchDetailController.selectedImage.value),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            16.vertical,
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: branchDetailController.imageUrls.length,
                itemBuilder: (context, index) {
                  String imageUrl = branchDetailController.imageUrls[index];

                  return GestureDetector(
                    onTap: () =>
                        branchDetailController.changeSelectedImage(index),
                    child: Obx(() => Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  branchDetailController.selectedImage.value ==
                                          branchDetailController
                                              .selectedImageUrls[index]
                                      ? Colors.blue
                                      : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: SvgPicture.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
