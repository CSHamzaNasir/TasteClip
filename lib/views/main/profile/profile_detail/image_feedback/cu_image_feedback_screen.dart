import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

import '../../../../../config/app_text_styles.dart';
import '../../../../../constant/app_colors.dart';
import '../../../../../constant/app_fonts.dart';
import '../../../../../widgets/app_background.dart';
import 'cu_image_feedback_controller.dart';

class CuImageFeedbackScreen extends StatelessWidget {
  CuImageFeedbackScreen({super.key});
  final controller = Get.put(CuImageFeedbackController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: Scaffold(
        body: Obx(() {
          if (controller.feedbackList.isEmpty) {
            return Center(child: Text("Loading..."));
          }
          return Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50)),
                    color: AppColors.mainColor),
                child: Center(
                  child: Text("Image Feedback",
                      style: AppTextStyles.boldBodyStyle
                          .copyWith(color: AppColors.lightColor)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.feedbackList.length,
                  itemBuilder: (context, index) {
                    var feedback = controller.feedbackList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        spacing: 16,
                        children: [
                          Row(
                            spacing: 12,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: (feedback['branchThumbnail'] !=
                                            null &&
                                        feedback['branchThumbnail'].isNotEmpty)
                                    ? NetworkImage(feedback['branchThumbnail'])
                                    : null,
                                child: (feedback['branchThumbnail'] == null ||
                                        feedback['branchThumbnail'].isEmpty)
                                    ? Icon(Icons.image_not_supported, size: 25)
                                    : null,
                              ),
                              Column(
                                spacing: 4,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feedback['branch'],
                                    style: AppTextStyles.regularStyle.copyWith(
                                      color: AppColors.mainColor,
                                      fontFamily: AppFonts.sandBold,
                                    ),
                                  ),
                                  Text(
                                    '@${feedback['channelName']}',
                                    style: AppTextStyles.lightStyle.copyWith(
                                      color: AppColors.mainColor,
                                      fontFamily: AppFonts.sandSemiBold,
                                    ),
                                  )
                                ],
                              ),
                              Spacer(),
                              SvgPicture.asset(AppAssets.vertMore)
                            ],
                          ),
                          (feedback['image_url'] != null &&
                                  feedback['image_url'].isNotEmpty)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    feedback['image_url'],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(Icons.image_not_supported, size: 25),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.primaryColor),
                                color:
                                    AppColors.mainColor.withCustomOpacity(.2),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              feedback['image_title'],
                              style: AppTextStyles.lightStyle.copyWith(
                                color: AppColors.mainColor,
                                fontFamily: AppFonts.sandSemiBold,
                              ),
                            ),
                          ),
                          Row(
                            spacing: 4,
                            children: [
                              Text('Rating:',
                                  style: AppTextStyles.regularStyle.copyWith(
                                    color: AppColors.mainColor,
                                    fontFamily: AppFonts.sandBold,
                                  )),
                              Text(
                                feedback['rating'],
                                style: AppTextStyles.regularStyle.copyWith(
                                  color: const Color(0xFFAB8104),
                                ),
                              ),
                              Spacer(),
                              Text(
                                feedback['created_at'],
                                style: AppTextStyles.lightStyle.copyWith(
                                  color: AppColors.mainColor,
                                  fontFamily: AppFonts.sandSemiBold,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
