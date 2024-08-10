import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasteclip/constant/app_bar.dart';
import 'package:tasteclip/constant/app_button.dart';
import 'package:tasteclip/constant/app_text.dart';
import '../../config/app_router.dart';
import '../../constant/app_gradient.dart';
import '../../constant/app_logo.dart';

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(
                    iconColor: secondaryColor,
                    route: ('/role'),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  const Center(
                    child: AutoSizeText(
                      'Welcome to the\nTaste Clip',
                      style: TextStyle(
                          fontSize: h1,
                          color: textColor,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                  const Hero(tag: 'applogo', child: Center(child: AppLogo())),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  AppButton(
                      backgroundColor: primaryColor,
                      foregroundColor: lightColor,
                      text: 'Login',
                      onPressed: () {
                        AppRouter.push(AppRouter.login);
                      }),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  AppButton(
                      backgroundColor: primaryColor,
                      foregroundColor: lightColor,
                      text: 'Sign Up',
                      onPressed: () {
                        AppRouter.push(AppRouter.signup);
                      }),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Row(children: [
                    Expanded(child: Divider(color: primaryColor)),
                    Text(
                      " Or Continue with ",
                      style: TextStyle(fontSize: h5, color: mainColor),
                    ),
                    Expanded(child: Divider(color: primaryColor)),
                  ]),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          icon: FontAwesomeIcons.google,
                          btnSideClr: true,
                          foregroundColor: textColor,
                          backgroundColor: lightColor,
                          text: 'Google',
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
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
                ],
              ),
            )),
      ),
    );
  }
}
