import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/channel/event/create_event_controller.dart';
import 'package:tasteclip/modules/channel/event/model/event_model.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key, required this.event});
  final EventModel event;

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'TBD';
    return DateFormat('EEEE, MMM d, yyyy • h:mm a').format(dateTime);
  }

  String _formatDuration(DateTime? startTime, DateTime? endTime) {
    if (startTime == null || endTime == null) return '';

    final duration = endTime.difference(startTime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0) {
      return '$hours hr${hours > 1 ? 's' : ''}${minutes > 0 ? ' $minutes min' : ''}';
    } else {
      return '$minutes min';
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventController>();
    final isInterested = event.interestedUsers.containsKey(controller.userId);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.mainColor,
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.share,
                    color: AppColors.whiteColor,
                  ),
                  onPressed: () {
                    // Share functionality
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Event Image
                  Hero(
                    tag: 'event-image-${event.id}',
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: event.branchImage,
                      placeholder: (context, url) =>
                          const Center(child: CupertinoActivityIndicator()),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.6),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  // Bottom content
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Discount badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '${event.discount}% OFF',
                            style: AppTextStyles.regularStyle.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        12.vertical,
                        // Restaurant name
                        Text(
                          event.restaurantName.toUpperCase(),
                          style: AppTextStyles.regularStyle.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        8.vertical,
                        // Event name
                        Text(
                          event.eventName,
                          style: AppTextStyles.headingStyle1.copyWith(
                            color: AppColors.whiteColor,
                            fontFamily: AppFonts.sandSemiBold,
                            fontSize: 28,
                            shadows: [
                              Shadow(
                                offset: const Offset(0, 1),
                                blurRadius: 3.0,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Details Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mainColor.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date and Time
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SvgPicture.asset(
                                height: 24,
                                width: 24,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  AppColors.mainColor,
                                  BlendMode.srcIn,
                                ),
                                AppAssets.eventReg,
                              ),
                            ),
                            16.horizontal,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date & Time',
                                    style: AppTextStyles.bodyStyle.copyWith(
                                      color: AppColors.textColor,
                                      fontFamily: AppFonts.sandBold,
                                    ),
                                  ),
                                  4.vertical,
                                  Text(
                                    _formatDateTime(event.startTime),
                                    style: AppTextStyles.regularStyle.copyWith(
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                  if (event.startTime != null &&
                                      event.endTime != null) ...[
                                    4.vertical,
                                    Text(
                                      'Duration: ${_formatDuration(event.startTime, event.endTime)}',
                                      style:
                                          AppTextStyles.regularStyle.copyWith(
                                        color: AppColors.textColor
                                            .withOpacity(0.7),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),

                        16.vertical,
                        const Divider(),
                        16.vertical,

                        // Location
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SvgPicture.asset(
                                height: 24,
                                width: 24,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  AppColors.mainColor,
                                  BlendMode.srcIn,
                                ),
                                AppAssets.locIcon,
                              ),
                            ),
                            16.horizontal,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Location',
                                    style: AppTextStyles.bodyStyle.copyWith(
                                      color: AppColors.textColor,
                                      fontFamily: AppFonts.sandBold,
                                    ),
                                  ),
                                  4.vertical,
                                  Text(
                                    event.eventLocation,
                                    style: AppTextStyles.regularStyle.copyWith(
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                  4.vertical,
                                  Text(
                                    '${event.branchName}, ${event.restaurantName}',
                                    style: AppTextStyles.regularStyle.copyWith(
                                      color:
                                          AppColors.textColor.withOpacity(0.7),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        16.vertical,
                        const Divider(),
                        16.vertical,

                        // Interested Users
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.people,
                                size: 24,
                                color: AppColors.mainColor,
                              ),
                            ),
                            16.horizontal,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Interested',
                                    style: AppTextStyles.bodyStyle.copyWith(
                                      color: AppColors.textColor,
                                      fontFamily: AppFonts.sandBold,
                                    ),
                                  ),
                                  4.vertical,
                                  Text(
                                    '${event.interestedUsers.length} ${event.interestedUsers.length == 1 ? 'person' : 'people'} interested',
                                    style: AppTextStyles.regularStyle.copyWith(
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  24.vertical,

                  // About this event
                  Text(
                    "About this event",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandBold,
                      fontSize: 18,
                    ),
                  ),
                  16.vertical,
                  Text(
                    event.eventDescription,
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.textColor,
                      height: 1.5,
                    ),
                  ),

                  24.vertical,

                  // Hosted by
                  Text(
                    "Hosted by",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandBold,
                      fontSize: 18,
                    ),
                  ),
                  16.vertical,
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.mainColor.withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              event.restaurantName.isNotEmpty
                                  ? event.restaurantName
                                      .substring(0, 1)
                                      .toUpperCase()
                                  : 'R',
                              style: AppTextStyles.headingStyle1.copyWith(
                                color: AppColors.mainColor,
                              ),
                            ),
                          ),
                        ),
                        16.horizontal,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.restaurantName,
                                style: AppTextStyles.bodyStyle.copyWith(
                                  color: AppColors.textColor,
                                  fontFamily: AppFonts.sandBold,
                                ),
                              ),
                              4.vertical,
                              Text(
                                event.branchName,
                                style: AppTextStyles.regularStyle.copyWith(
                                  color: AppColors.textColor.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  32.vertical,
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.mainColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.calendar_month,
                  color: AppColors.mainColor,
                ),
              ),
              16.horizontal,
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.toggleInterest(event),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: isInterested
                          ? AppColors.mainColor.withOpacity(0.1)
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(16),
                      border: isInterested
                          ? Border.all(color: AppColors.mainColor)
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isInterested ? Icons.favorite : Icons.favorite_border,
                          color: isInterested
                              ? AppColors.mainColor
                              : AppColors.whiteColor,
                          size: 20,
                        ),
                        8.horizontal,
                        Text(
                          isInterested ? 'Interested' : 'I\'m Interested',
                          style: AppTextStyles.bodyStyle.copyWith(
                            color: isInterested
                                ? AppColors.mainColor
                                : AppColors.whiteColor,
                            fontFamily: AppFonts.sandSemiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
