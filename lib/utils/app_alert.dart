import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/constant/app_colors.dart';

class AppAlerts {
  static void showSnackbar({required bool isSuccess, required String message}) {
    Get.snackbar(
      isSuccess ? 'Success' : 'Error',
      message,
      backgroundColor: isSuccess ? AppColors.mainColor : Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
    );
  }
}
