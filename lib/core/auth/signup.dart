import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/constant/app_button.dart';
import 'package:tasteclip/constant/app_feild.dart';
import 'package:tasteclip/constant/app_gradient.dart';
import 'package:tasteclip/constant/app_text.dart';
import 'package:tasteclip/constant/assets_path.dart';
import 'package:tasteclip/core/auth/provider/auth_provider.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      decoration: const BoxDecoration(gradient: primaryWhiteGradient),
      child: Padding(
          padding: const EdgeInsets.only(left: 22.0, right: 22.0),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: MediaQuery.of(context).size.height * .15),
              Row(
                children: [
                  const Text('Create Your\nAccount',
                      style: TextStyle(
                          fontSize: h2,
                          color: textColor,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Hero(
                    tag: 'textlogo',
                    child: SvgPicture.asset(
                      appLogo1,
                      height: 50,
                      width: 50,
                    ),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              const AppFeild(
                  prefixIcon: Icons.person,
                  feildFocusClr: true,
                  iconSize: 14,
                  iconColor: mainColor,
                  hintText: 'username'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AppFeild(
                  controller: _emailController,
                  feildFocusClr: true,
                  prefixIcon: Icons.mail,
                  iconSize: 14,
                  iconColor: mainColor,
                  hintText: 'email'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AppFeild(
                  controller: _passwordController,
                  feildFocusClr: true,
                  isPasswordField: true,
                  prefixIcon: Icons.lock,
                  iconSize: 14,
                  iconColor: mainColor,
                  hintText: 'password'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              AppButton(
                text: 'Sign up',
                isLoading: _isLoading,
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  await ref.read(authNotifierProvider.notifier).signUp(
                        context,
                        _emailController.text,
                        _passwordController.text,
                        "",
                        "",
                        "",
                        "",
                      );

                  setState(() {
                    _isLoading = false;
                  });
                },
                foregroundColor: lightColor,
                backgroundColor: textColor,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              const Row(children: [
                Expanded(child: Divider(color: primaryColor)),
                Text(
                  " Or Continue with ",
                  style: TextStyle(
                      fontSize: h5,
                      color: mainColor,
                      fontWeight: FontWeight.w500),
                ),
                Expanded(child: Divider(color: primaryColor)),
              ]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Hero(
                tag: 'googlePHhonebtn',
                child: Row(
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
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Expanded(
                      child: AppButton(
                        icon: Icons.phone,
                        text: 'Phone',
                        foregroundColor: lightColor,
                        backgroundColor: mainColor,
                        onPressed: () {
                          AppRouter.push(AppRouter.phoneAuth);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              RichText(
                  text: TextSpan(
                      text: 'Already have an account? ',
                      style: const TextStyle(fontSize: h5, color: mainColor),
                      children: [
                    TextSpan(
                      text: 'Sign in',
                      style: const TextStyle(
                          fontSize: h5,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          AppRouter.push(AppRouter.login);
                        },
                    )
                  ]))
            ]),
          )),
    ));
  }
}
