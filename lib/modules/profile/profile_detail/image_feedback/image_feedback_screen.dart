import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/config/app_enum.dart';

import '../../../../config/app_text_styles.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_fonts.dart';
import '../../../../widgets/app_background.dart';
import 'image_feedback_controller.dart';

class ImageFeedbackScreen extends StatelessWidget {
  final UserRole role;

  const ImageFeedbackScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageFeedbackController(role: role));
    return AppBackground(
      isDefault: false,
      child: Scaffold(
        body: Obx(() {
          if (controller.feedbackList.isEmpty) {
            return Center(child: CupertinoActivityIndicator());
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
                child: ListView.separated(
                  itemCount: controller.feedbackList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16),
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
                                backgroundColor: Colors.grey[300],
                                child: (feedback['branchThumbnail'] != null &&
                                        feedback['branchThumbnail'].isNotEmpty)
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.network(
                                          feedback['branchThumbnail'],
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                                child:
                                                    CupertinoActivityIndicator());
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(
                                                Icons.image_not_supported,
                                                size: 25,
                                                color: Colors.grey);
                                          },
                                        ),
                                      )
                                    : Icon(Icons.image_not_supported,
                                        size: 25, color: Colors.grey),
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
                          (feedback['imageUrl'] != null &&
                                  feedback['imageUrl'].isNotEmpty)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    feedback['imageUrl'],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child; 
                                      }
                                      return Center(
                                        child:
                                            CupertinoActivityIndicator(), 
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.image_not_supported,
                                          size: 25);
                                    },
                                  ),
                                )
                              : Icon(Icons.image_not_supported, size: 25),
                          Container(
                            width: double.infinity,
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
