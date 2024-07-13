import 'package:auto_size_text/auto_size_text.dart';
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: lightWhiteGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 22.0, right: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(
                iconColor: secondaryColor,
                route: ('/role'),
              ),
              Center(
                child: AutoSizeText(
                  'Welcome to the\nTaste Clip',
                  style: AppTextStyles.style4,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              const Center(child: RoleImg()),
              SizedBox(height: Get.height * 0.01),
              const AuthButton()
            ],
          ),
        ),
      ),
    );
  }
}
