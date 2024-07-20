import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tasteclip/core/widgets/auth_button.dart';
import 'package:tasteclip/constant/app_bar.dart';
import 'package:tasteclip/constant/app_text.dart';
import '../../../constant/app_gradient.dart';
import '../../../constant/app_logo.dart';

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
              const Center(child: AppLogo()),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              const AuthButton()
            ],
          ),
        ),
      ),
    );
  }
}
