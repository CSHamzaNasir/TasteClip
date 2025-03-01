import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/widgets/app_feild.dart';

class FeedbackDetailController extends GetxController {
  var isBookmarked = false.obs;
  var feedback = {}.obs;

  void toggleBookmark() {
    isBookmarked.value = !isBookmarked.value;
  }

  void setFeedback(Map<String, dynamic> data) {
    feedback.value = data;
  }

  void showAddCommentSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 6,
              children: [
                Text("Comments",
                    style: AppTextStyles.bodyStyle.copyWith(
                        fontFamily: AppFonts.sandBold,
                        color: AppColors.textColor.withCustomOpacity(.8))),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: AppColors.greyColor, shape: BoxShape.circle),
                  child: Text("28",
                      style: AppTextStyles.regularStyle
                          .copyWith(color: AppColors.mainColor)),
                )
              ],
            ),
            SizedBox(height: 12),
            AppFeild(
              hintText: "Write a comment...",
              hintTextColor: AppColors.primaryColor,
              feildFocusClr: true,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
