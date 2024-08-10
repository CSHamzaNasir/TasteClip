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

class Signin extends ConsumerStatefulWidget {
  const Signin({super.key});

  @override
  SigninState createState() => SigninState();
}

class SigninState extends ConsumerState<Signin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(gradient: primaryWhiteGradient),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                        color: secondaryColor, fontSize: h2, fontWeight: bold),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Hero(
                    tag: 'textlogo',
                    child: SvgPicture.asset(
                      appLogo1,
                      height: 58,
                      width: 58,
                    ),
                  ),
                  const SizedBox(height: 15),
                  RichText(
                      text: TextSpan(
                          text: 'Taste',
                          style: const TextStyle(
                              fontSize: h3,
                              color: secondaryColor,
                              fontWeight: bold),
                          children: <TextSpan>[
                        TextSpan(
                          text: 'Clip',
                          style: const TextStyle(
                              fontSize: h3,
                              color: mainColor,
                              fontWeight: semibold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              AppRouter.push(AppRouter.login);
                            },
                        )
                      ])),
                  const SizedBox(height: 36),
                  AppFeild(
                    controller: _emailController,
                    prefixIcon: Icons.email_outlined,
                    hintText: 'email',
                    iconColor: mainColor,
                    iconSize: 21,
                  ),
                  const SizedBox(height: 15),
                  AppFeild(
                    controller: _passwordController,
                    isPasswordField: true,
                    iconColor: mainColor,
                    iconSize: 21,
                    prefixIcon: Icons.lock_outline,
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 5),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forget Password',
                      style: TextStyle(
                          color: mainColor, fontSize: h5, fontWeight: regular),
                    ),
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    isLoading: _isLoading,
                    foregroundColor: lightColor,
                    backgroundColor: textColor,
                    text: 'Sign in',
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await ref.read(authNotifierProvider.notifier).signIn(
                          context,
                          _emailController.text,
                          _passwordController.text);
                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Expanded(
                          child: AppButton(
                            icon: Icons.phone,
                            text: 'Phone',
                            foregroundColor: lightColor,
                            backgroundColor: mainColor,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            fontSize: h5,
                            color: secondaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          AppRouter.push(AppRouter.signup);
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                              fontSize: h5,
                              color: mainColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
