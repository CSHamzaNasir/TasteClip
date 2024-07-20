import 'package:flutter/material.dart';
import 'package:tasteclip/core/widgets/role_button.dart';
import 'package:tasteclip/constant/app_logo.dart';
import 'package:tasteclip/constant/app_gradient.dart';
import 'package:tasteclip/constant/app_text.dart';
import '../../../responsive/role.dart';

class Role extends StatelessWidget {
  const Role({super.key});

  @override
  Widget build(BuildContext context) {
    RoleBtnProperties properties = RoleBtn.boardingImgSize(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: lightWhiteGradient,
          ),
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  Center(
                    child: Text(
                      'Welcome to the \n Taste Clip',
                      style: TextStyle(
                          fontSize: properties.title,
                          color: textColor,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Center(child: AppLogo()),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    'Get Started with...',
                    style: TextStyle(
                        fontSize: properties.subTitle,
                        color: textColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 19),
                  const RoleButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
