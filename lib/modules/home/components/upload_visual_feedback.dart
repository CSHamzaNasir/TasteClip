import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/review/Image/upload_feedback_screen.dart';

class UploadVisualFeedback extends StatelessWidget {
  const UploadVisualFeedback({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Get.to(
                () => UploadFeedbackScreen(category: FeedbackCategory.image)),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.redAccent.withCustomOpacity(.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.redAccent,
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Image",
                    style: AppTextStyles.regularStyle.copyWith(
                      color: Colors.redAccent,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blueAccent.withCustomOpacity(.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.video,
                  colorFilter: ColorFilter.mode(
                    Colors.blueAccent,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "Video",
                  style: AppTextStyles.regularStyle.copyWith(
                    color: Colors.blueAccent,
                    fontFamily: AppFonts.sandBold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
