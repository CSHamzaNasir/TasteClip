import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Add this import
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/auth/manager_auth/manager_auth_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';
import 'package:tasteclip/widgets/custom_appbar.dart';
import 'package:tasteclip/widgets/custom_box.dart';

class ManagerRegisterScreen extends StatelessWidget {
  ManagerRegisterScreen({super.key});
  final controller = Get.put(ManagerAuthController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: false,
      child: Scaffold(
        appBar: const CustomAppBar(
          showBackIcon: false,
          title: AppString.register,
          isDark: "true",
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppString.welcome,
                        style: AppTextStyles.headingStyle.copyWith(
                          color: AppColors.lightColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppString.alreadyHaveAnAccount,
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: AppColors.lightColor,
                            ),
                          ),
                          6.horizontal,
                          InkWell(
                            onTap: () => controller.goToLoginScreen(),
                            child: Text(
                              AppString.login,
                              style: AppTextStyles.boldBodyStyle.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      24.vertical,
                      CustomBox(
                        child: Column(
                          children: [
                            AppFeild(
                              controller: controller.restaurantNameController,
                              hintText: AppString.resturentName,
                            ),
                            16.vertical,
                            AppFeild(
                              controller: controller.branchAddressController,
                              hintText: AppString.address,
                            ),
                            16.vertical,
                            AppFeild(
                              controller: controller.businessEmailController,
                              hintText: AppString.businessEmail,
                            ),
                            16.vertical,
                            AppFeild(
                              controller: controller.passkeyController,
                              hintText: AppString.passkey,
                            ),
                            20.vertical,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
              child: Obx(() => controller.isLoading.value
                  ? SpinKitThreeBounce(
                      color: AppColors.textColor,
                      size: 25.0,
                    )
                  : AppButton(
                      text: 'Register',
                      onPressed: () {
                        if (!controller.isLoading.value) {
                          controller.registerManager();
                        }
                      },
                    )),
            )
          ],
        ),
      ),
    );
  }
}
