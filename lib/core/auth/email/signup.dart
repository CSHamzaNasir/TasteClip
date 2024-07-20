import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasteclip/constant/app_button.dart';
import 'package:tasteclip/core/widgets/feild_container.dart';
import 'package:tasteclip/constant/app_bar.dart';
import 'package:tasteclip/constant/app_gradient.dart';
import 'package:tasteclip/constant/app_text.dart';

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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  const Text('Create Your\nAccount',
                      style: TextStyle(
                          fontSize: h2,
                          color: textColor,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  const FieldContainer(
                      prefixIcon: Icons.person,
                      feildFocusClr: true,
                      iconSize: 14,
                      iconColor: mainColor,
                      hintText: 'username'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const FieldContainer(
                      feildFocusClr: true,
                      prefixIcon: Icons.mail,
                      iconSize: 14,
                      iconColor: mainColor,
                      hintText: 'email'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const FieldContainer(
                      feildFocusClr: true,
                      isPasswordField: true,
                      prefixIcon: Icons.lock,
                      iconSize: 14,
                      iconColor: mainColor,
                      hintText: 'password'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  AppButton(
                    text: 'Sign up',
                    onPressed: () {},
                    foregroundColor: lightColor,
                    backgroundColor: textColor,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Center(
                      child: RichText(
                          text: TextSpan(
                              text: 'Already have an account? ',
                              style: const TextStyle(
                                  fontSize: h5, color: mainColor),
                              children: <TextSpan>[
                        TextSpan(
                          text: 'Sign in',
                          style: const TextStyle(
                              fontSize: h5, color: secondaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              log("Sign in tapped");
                            },
                        )
                      ]))),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const Row(children: [
                    Expanded(child: Divider(color: primaryColor)),
                    Text(
                      " or continue with ",
                      style: TextStyle(fontSize: h5, color: mainColor),
                    ),
                    Expanded(child: Divider(color: primaryColor)),
                  ]),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          btnSideClr: true,
                          icon: FontAwesomeIcons.google,
                          text: 'Google',
                          foregroundColor: textColor,
                          backgroundColor: lightColor,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Expanded(
                        child: AppButton(
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
