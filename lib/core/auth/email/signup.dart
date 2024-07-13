import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tasteclip/core/widgets/custom_button.dart';
import 'package:tasteclip/core/widgets/feild_container.dart';
import 'package:tasteclip/theme/appbar.dart';
import 'package:tasteclip/theme/gradient.dart';
import 'package:tasteclip/theme/text_style.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      decoration: const BoxDecoration(gradient: primaryWhiteGradient),
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 22.0, right: 22.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CardAppBar(
                      iconColor: secondaryColor,
                      route: ('/authentication'),
                      containerColor: lightColor),
                  SizedBox(height: Get.height * .05),
                  Text('Create Your\nAccount', style: AppTextStyles.style4),
                  SizedBox(height: Get.height * .04),
                  const FieldContainer(
                      prefixIcon: Icons.person,
                      feildFocusClr: true,
                      iconSize: 14,
                      iconColor: mainColor,
                      hintText: 'username'),
                  SizedBox(height: Get.height * .02),
                  const FieldContainer(
                      feildFocusClr: true,
                      prefixIcon: Icons.mail,
                      iconSize: 14,
                      iconColor: mainColor,
                      hintText: 'email'),
                  SizedBox(height: Get.height * .02),
                  const FieldContainer(
                      feildFocusClr: true,
                      isPasswordField: true,
                      prefixIcon: Icons.lock,
                      iconSize: 14,
                      iconColor: mainColor,
                      hintText: 'password'),
                  SizedBox(height: Get.height * .03),
                  CustomButton(
                    text: 'Sign up',
                    onPressed: () {},
                    foregroundColor: lightColor,
                    backgroundColor: textColor,
                  ),
                  SizedBox(height: Get.height * .02),
                  Center(
                      child: RichText(
                          text: TextSpan(
                              text: 'Already have an account? ',
                              style: AppTextStyles.style2,
                              children: <TextSpan>[
                        TextSpan(
                          text: 'Sign in',
                          style: AppTextStyles.style11,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              log("Sign in tapped");
                            },
                        )
                      ]))),
                  SizedBox(height: Get.height * .05),
                  Row(children: [
                    const Expanded(child: Divider(color: primaryColor)),
                    Text(
                      " or continue with ",
                      style: AppTextStyles.style2,
                    ),
                    const Expanded(child: Divider(color: primaryColor)),
                  ]),
                  SizedBox(height: Get.height * .02),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          btnSideClr: true,
                          icon: FontAwesomeIcons.google,
                          text: 'Google',
                          foregroundColor: textColor,
                          backgroundColor: lightColor,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: Get.width * .05),
                      Expanded(
                        child: CustomButton(
                          icon: Icons.phone,
                          text: 'Phone',
                          foregroundColor: lightColor,
                          backgroundColor: primaryColor,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ])),
      ),
    ));
  }
}
