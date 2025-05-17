import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/channel/controllers/channel_home_controller.dart';
import 'package:tasteclip/utils/app_alert.dart';
import 'package:tasteclip/widgets/app_background.dart';

class UpdateBranchImageScreen extends StatefulWidget {
  const UpdateBranchImageScreen({super.key});

  @override
  State<UpdateBranchImageScreen> createState() =>
      _UpdateBranchImageScreenState();
}

class _UpdateBranchImageScreenState extends State<UpdateBranchImageScreen> {
  final ChannelHomeController controller = Get.find();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  var isLoading = false.obs;

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
      }
    } catch (e) {
      AppAlerts.showSnackbar(
          isSuccess: false, message: "Failed to pick image: $e");
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    try {
      isLoading.value = true;
      final userId = controller.auth.currentUser?.uid;
      if (userId == null) return;

      // Upload to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('branch_images')
          .child('$userId.jpg');

      await storageRef.putFile(_imageFile!);
      final downloadUrl = await storageRef.getDownloadURL();

      // Update in Firestore
      await _updateBranchImage(downloadUrl);

      AppAlerts.showSnackbar(
          isSuccess: true, message: "Image updated successfully");
      Get.back();
    } catch (e) {
      AppAlerts.showSnackbar(
          isSuccess: false, message: "Failed to upload image: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _updateBranchImage(String imageUrl) async {
    try {
      final userId = controller.auth.currentUser?.uid;
      if (userId == null) return;

      final restaurantName = controller.managerData.value?['restaurantName'];
      if (restaurantName == null) return;

      // Get current branches
      final doc = await controller.firestore
          .collection('restaurants')
          .doc(restaurantName)
          .get();

      if (!doc.exists) return;

      List<dynamic> branches = doc['branches'];

      // Find and update the branch
      for (int i = 0; i < branches.length; i++) {
        if (branches[i]['branchId'] == userId) {
          branches[i]['branchThumbnail'] = imageUrl;
          break;
        }
      }

      // Update the document
      await controller.firestore
          .collection('restaurants')
          .doc(restaurantName)
          .update({'branches': branches});

      // Update local data
      controller.managerData.value?['branchThumbnail'] = imageUrl;
      controller.managerData.refresh();
    } catch (e) {
      throw Exception("Failed to update branch image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.transparent,
          elevation: 0,
          title: Text("Update Branch Image",
              style: AppTextStyles.boldBodyStyle.copyWith(
                color: AppColors.textColor,
              )),
          actions: [
            Obx(() => isLoading.value
                ? Row(
                    children: [
                      CupertinoActivityIndicator(
                        color: AppColors.mainColor,
                      ),
                      Text(
                        "Wait",
                        style: AppTextStyles.lightStyle.copyWith(
                            color: AppColors.textColor,
                            fontFamily: AppFonts.sandSemiBold),
                      ),
                      6.horizontal,
                    ],
                  )
                : IconButton(
                    icon: Icon(
                      Icons.check,
                      color: AppColors.mainColor,
                    ),
                    onPressed: _uploadImage,
                  )),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.vertical,
              Text(
                "Let’s add your profile",
                style: AppTextStyles.headingStyle.copyWith(
                  color: AppColors.textColor,
                  fontFamily: AppFonts.sandBold,
                  fontSize: 30,
                ),
              ),
              8.vertical,
              Text(
                "People will see this on your community profile",
                style: AppTextStyles.bodyStyle.copyWith(
                  color: AppColors.mainColor,
                  fontFamily: AppFonts.sandBold,
                ),
              ),
              32.vertical,
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: AppColors.mainColor.withCustomOpacity(0.1),
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : (controller.managerData.value?['branchThumbnail'] !=
                                        null &&
                                    controller.managerData
                                        .value?['branchThumbnail']!.isNotEmpty
                                ? NetworkImage(controller
                                    .managerData.value?['branchThumbnail'])
                                : AssetImage(AppAssets.branchIcon))
                            as ImageProvider,
                    child: _imageFile == null &&
                            (controller.managerData.value?['branchThumbnail'] ==
                                    null ||
                                controller.managerData
                                    .value?['branchThumbnail']!.isEmpty)
                        ? Icon(Icons.add_a_photo,
                            size: 40, color: AppColors.mainColor)
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Tap to change image",
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.mainColor,
                    fontFamily: AppFonts.sandBold,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
