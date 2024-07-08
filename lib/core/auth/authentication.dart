import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/core/widgets/auth_button.dart';
import 'package:tasteclip/theme/appbar.dart';
import 'package:tasteclip/theme/text_style.dart';
import '../../theme/gradient.dart';
import '../widgets/role_img.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.authAppbar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: lightWhiteGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Welcome to the \n Taste Clip',
                  style: AppTextStyles.style4,
                  textAlign: TextAlign.center,
                ),
              ),
              const Center(child: RoleImg()),
              SizedBox(height: Get.height * 0.03),
              const AuthButton()
            ],
          ),
        ),
      ),
    );
  }
}
