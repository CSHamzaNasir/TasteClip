import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/core/widgets/role_button.dart';
import 'package:tasteclip/core/widgets/role_img.dart';
import 'package:tasteclip/theme/style.dart';

class Role extends StatelessWidget {
  const Role({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
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
              Text(
                'Get Started with...',
                style: AppTextStyles.style20,
              ),
              SizedBox(height: Get.height * 0.02),
              const RoleButton(),
            ],
          ),
        ),
      ),
    );
  }
}
