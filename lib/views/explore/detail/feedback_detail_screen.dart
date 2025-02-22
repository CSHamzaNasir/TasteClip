import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/widgets/app_button.dart';

import '../../../config/app_text_styles.dart';

class FeedbackDetailScreen extends StatelessWidget {
  final Map<String, dynamic> feedback;

  const FeedbackDetailScreen({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: AppColors.lightColor,
                ),
                color: Colors.black.withCustomOpacity(0.3),
              ),
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                size: 18,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: AppColors.lightColor,
                ),
                color: Colors.black.withCustomOpacity(0.3),
              ),
              child: SvgPicture.asset(
                colorFilter: ColorFilter.mode(
                  AppColors.lightColor,
                  BlendMode.srcIn,
                ),
                AppAssets.vertMore,
              ),
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          "Feedback Details",
          style: AppTextStyles.boldBodyStyle.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: feedback['image_url'] != null &&
                    feedback['image_url'].isNotEmpty
                ? Image.network(
                    feedback['image_url'],
                    fit: BoxFit.cover,
                  )
                : Container(color: Colors.grey),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withCustomOpacity(0.6),
                  Colors.black.withCustomOpacity(0.3),
                  Colors.black.withCustomOpacity(0.6),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          Expanded(
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              feedback['branch'] ?? "No Title",
                              style: AppTextStyles.headingStyle1.copyWith(
                                color: AppColors.textColor,
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
                            style: AppTextStyles.lightStyle.copyWith(
                              color: AppColors.textColor,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: AppColors.textColor,
                      ),
                      Text(
                        feedback['image_title'],
                        style: AppTextStyles.bodyStyle.copyWith(
                          color: AppColors.textColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.access_time, size: 18, color: Colors.grey),
                          SizedBox(width: 6),
                          Text(
                            feedback['created_at'],
                            style: AppTextStyles.lightStyle.copyWith(
                              color: AppColors.textColor.withCustomOpacity(.8),
                            ),
                          ),
                        ],
                      ),
                      AppButton(
                        text: "Add to bookmark",
                        onPressed: () {},
                        btnRadius: 50,
                      )
                    ],
                  ),
                ),
                16.vertical,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
