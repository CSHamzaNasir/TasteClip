import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_feild.dart';

import '../../config/app_text_styles.dart' show AppTextStyles;
import '../../constant/app_fonts.dart';
import 'watch_feedback_controller.dart';

class WatchFeedbackScreen extends StatelessWidget {
  WatchFeedbackScreen({super.key});
  final controller = Get.put(WatchFeedbackController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: AppFeild(
                        feildClr: AppColors.whiteColor,
                        feildSideClr: false,
                        radius: 50,
                        hintText: "hintText",
                        isSearchField: true,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: AppColors.btnUnSelectColor
                                  .withCustomOpacity(.5))),
                      child: SvgPicture.asset(
                        AppAssets.menuIcon,
                      ),
                    ),
                  ],
                ),
                16.vertical,
                Obx(() {
                  if (controller.feedbackList.isEmpty) {
                    return Center(child: Text("Loading..."));
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16, 
                              mainAxisSpacing: 16,
                              childAspectRatio: .9,
                            ),
                            itemCount: controller.feedbackList.length,
                            itemBuilder: (context, index) {
                              var feedback = controller.feedbackList[index];
                              return Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 8,
                                  children: [
                                    (feedback['image_url'] != null &&
                                            feedback['image_url'].isNotEmpty)
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12)),
                                            child: Image.network(
                                              feedback['image_url'],
                                              width: double.infinity,
                                              height: 130,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Icon(Icons.image_not_supported,
                                            size: 25),
                                    Row(
                                      spacing: 6,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '@${feedback['channelName']}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.lightStyle
                                                .copyWith(
                                              color: AppColors.textColor
                                                  .withCustomOpacity(.5),
                                              fontFamily: AppFonts.sandSemiBold,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          size: 16,
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          feedback['rating'],
                                          style:
                                              AppTextStyles.lightStyle.copyWith(
                                            color: AppColors.textColor
                                                .withCustomOpacity(.5),
                                            fontFamily: AppFonts.sandSemiBold,
                                          ),
                                        )
                                      ],
                                    ),
                                    // Text(
                                    //   '@${feedback['channelName']}',
                                    //   style: AppTextStyles.lightStyle.copyWith(
                                    //     color: AppColors.mainColor,
                                    //     fontFamily: AppFonts.sandSemiBold,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
