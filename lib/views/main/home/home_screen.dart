import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/data/repositories/auth_repository_impl.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/views/main/home/home_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import '../../../widgets/under_dev.dart';
import 'components/content_card.dart';
import 'components/home_topbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
            body: GetX<HomeController>(
                init: HomeController(authRepository: AuthRepositoryImpl()),
                builder: (controller) {
                  if (controller.user.value == null) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final userData = controller.user.value!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        4.vertical,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                showUnderDevelopmentDialog(context,
                                    "This feature is under development.");
                              },
                              icon: Icon(Icons.menu),
                              color: AppColors.mainColor,
                            ),
                            InkWell(
                              onTap: controller.goToProfileScreen,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 35,
                                    width: 115,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                        child: Text(
                                      userData.userName.length > 8
                                          ? '${userData.userName.substring(0, 8)}...'
                                          : userData.userName,
                                      style: AppTextStyles.lightStyle.copyWith(
                                        color: AppColors.lightColor,
                                      ),
                                    )),
                                  ),
                                  Positioned(
                                    left: -17,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 35,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg'), // Replace with your image source
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showUnderDevelopmentDialog(context,
                                    "This feature is under development.");
                              },
                              icon: Icon(Icons.notifications_outlined),
                              color: AppColors.mainColor,
                            ),
                          ],
                        ),
                        20.vertical,
                        Text(
                          AppString.capturingExpMotion,
                          style: AppTextStyles.headingStyle1.copyWith(
                            color: AppColors.textColor,
                            fontFamily: AppFonts.popinsBold,
                          ),
                        ),
                        24.vertical,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HomeTopBar(
                              onTap: () => showUnderDevelopmentDialog(context,
                                  "This feature is under development."),
                              icon: Icons.person,
                              title: AppString.profile,
                            ),
                            HomeTopBar(
                              onTap: () => showUnderDevelopmentDialog(context,
                                  "This feature is under development."),
                              icon: Icons.currency_exchange,
                              title: AppString.reward,
                            ),
                            HomeTopBar(
                              onTap: () => showUnderDevelopmentDialog(context,
                                  "This feature is under development."),
                              icon: Icons.favorite_outline,
                              title: AppString.favourite,
                            ),
                            HomeTopBar(
                              onTap: () => showUnderDevelopmentDialog(context,
                                  "This feature is under development."),
                              icon: Icons.settings,
                              title: AppString.setting,
                            ),
                          ],
                        ),
                        24.vertical,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppString.explore,
                            style: AppTextStyles.headingStyle1.copyWith(
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                        24.vertical,
                        HomeContentCard(
                          onTap: () => showUnderDevelopmentDialog(
                              context, "This feature is under development."),
                          width: 1,
                          imageIcon: AppAssets.shineStar,
                          title: AppString.clickHereForEssentailFood,
                        ),
                        16.vertical,
                        Row(
                          children: [
                            Expanded(
                              child: HomeContentCard(
                                imageIcon: AppAssets.shineStar,
                                title: AppString.watchFeedback,
                              ),
                            ),
                            12.horizontal,
                            Expanded(
                              child: HomeContentCard(
                                onTap: () => showUnderDevelopmentDialog(context,
                                    "This feature is under development."),
                                imageIcon: AppAssets.shineStar,
                                title: AppString.exploreRestaurant,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                })),
      ),
    );
  }
}
