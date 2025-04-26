import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/channel/event/model/event_model.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key, required this.event});
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor.withCustomOpacity(.9),
      body: Column(
        children: [
          CachedNetworkImage(
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: event.branchImage,
            placeholder: (context, url) =>
                const Center(child: CupertinoActivityIndicator()),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
          ),
          Transform.translate(
            offset: const Offset(0, -70),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.whiteColor,
              ),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.eventName,
                    style: AppTextStyles.headingStyle1.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandSemiBold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      SvgPicture.asset(
                        height: 18,
                        width: 18,
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                            AppColors.textColor, BlendMode.srcIn),
                        AppAssets.locIcon,
                      ),
                      Text(event.eventLocation,
                          style: AppTextStyles.regularStyle.copyWith(
                            color: AppColors.textColor.withCustomOpacity(.5),
                          ))
                    ],
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      SvgPicture.asset(
                        height: 18,
                        width: 18,
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                            AppColors.textColor, BlendMode.srcIn),
                        AppAssets.eventReg,
                      ),
                      Text(event.startTime.toString(),
                          style: AppTextStyles.regularStyle.copyWith(
                            color: AppColors.textColor.withCustomOpacity(.5),
                          ))
                    ],
                  ),
                  Text(
                    '${event.interestedUsers.length} users interested',
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                  16.vertical,
                  Text(
                    "About this event",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                  Text(
                    event.eventDescription,
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                    "Hosted by",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${event.restaurantName} - ',
                        style: AppTextStyles.bodyStyle.copyWith(
                          color: AppColors.textColor,
                          fontFamily: AppFonts.sandSemiBold,
                        ),
                      ),
                      Text(
                        event.branchName,
                        style: AppTextStyles.bodyStyle.copyWith(
                          color: AppColors.textColor,
                          fontFamily: AppFonts.sandSemiBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
