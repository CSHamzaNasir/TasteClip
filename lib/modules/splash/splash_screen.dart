import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/modules/splash/splash_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: GetBuilder<SplashController>(builder: (_) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: controller.splashAppLogo,
                          child: Image.asset(
                            AppAssets.appLogo,
                            width: 195,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Visibility(
                          visible: controller.splashText,
                          child: const Text(
                            'TasteClip',
                            style: AppTextStyles.boldStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !controller.splashText,
                    child: const Text(
                      'TasteClip',
                      style: AppTextStyles.semiBoldStyle,
                    ),
                  ),
                  6.vertical,
                  const Text(
                    'Version 1.0',
                    style: AppTextStyles.thinStyle,
                  ),
                  30.vertical,
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
