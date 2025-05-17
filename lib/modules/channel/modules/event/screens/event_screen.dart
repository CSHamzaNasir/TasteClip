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
import 'package:tasteclip/modules/channel/modules/event/controllers/create_event_controller.dart';
import 'package:tasteclip/modules/channel/modules/event/screens/event_detail_screen.dart';
import 'package:tasteclip/modules/channel/modules/event/model/event_model.dart';

class AllEventsScreen extends StatelessWidget {
  AllEventsScreen({super.key});

  final controller = Get.put(EventController());
  final RxInt _selectedTab = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Events',
          style: AppTextStyles.headingStyle1.copyWith(
            color: AppColors.textColor,
            fontFamily: AppFonts.sandBold,
            fontSize: 28,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(),
                16.vertical,
                Text(
                  'Loading events...',
                  style: AppTextStyles.regularStyle.copyWith(
                    color: AppColors.textColor.withCustomOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.event.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy,
                  size: 64,
                  color: AppColors.mainColor.withCustomOpacity(0.5),
                ),
                16.vertical,
                Text(
                  'No events found',
                  style: AppTextStyles.headingStyle.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
                8.vertical,
                Text(
                  'Check back later for upcoming events',
                  style: AppTextStyles.regularStyle.copyWith(
                    color: AppColors.textColor.withCustomOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              decoration: BoxDecoration(
                color: AppColors.mainColor.withCustomOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectedTab.value = 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: _selectedTab.value == 0
                              ? AppColors.mainColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            "Interested",
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: _selectedTab.value == 0
                                  ? AppColors.whiteColor
                                  : AppColors.textColor,
                              fontFamily: AppFonts.sandSemiBold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectedTab.value = 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: _selectedTab.value == 1
                              ? AppColors.mainColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            "All Events",
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: _selectedTab.value == 1
                                  ? AppColors.whiteColor
                                  : AppColors.textColor,
                              fontFamily: AppFonts.sandSemiBold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final filteredEvents = (_selectedTab.value == 0
                        ? controller.event.where((event) => event
                            .interestedUsers
                            .containsKey(controller.userId))
                        : controller.event.where((event) => !event
                            .interestedUsers
                            .containsKey(controller.userId)))
                    .toList();

                if (filteredEvents.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _selectedTab.value == 0
                              ? Icons.favorite_border
                              : Icons.event_note,
                          size: 48,
                          color: AppColors.mainColor.withCustomOpacity(0.5),
                        ),
                        16.vertical,
                        Text(
                          _selectedTab.value == 0
                              ? 'No interested events'
                              : 'No events to show',
                          style: AppTextStyles.headingStyle.copyWith(
                            color: AppColors.textColor,
                          ),
                        ),
                        8.vertical,
                        Text(
                          _selectedTab.value == 0
                              ? 'Mark events as interested to see them here'
                              : 'Check back later for new events',
                          style: AppTextStyles.regularStyle.copyWith(
                            color: AppColors.textColor.withCustomOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredEvents.length,
                  itemBuilder: (context, index) {
                    final event = filteredEvents[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => EventDetailScreen(
                              event: event,
                            ));
                      },
                      child: EventCard(
                        event: event,
                        isInterested: _selectedTab.value == 0,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventModel event;
  final bool isInterested;

  const EventCard({
    super.key,
    required this.event,
    required this.isInterested,
  });

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'TBD';
    return DateFormat('MMM d, yyyy • h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventController>();

    return Container(
      height: 380,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withCustomOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          
          Positioned.fill(
            child: Hero(
              tag: 'event-image-${event.id}',
              child: CachedNetworkImage(
                imageUrl: event.branchImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.mainColor.withCustomOpacity(0.1),
                  child: const Center(child: CupertinoActivityIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.mainColor.withCustomOpacity(0.1),
                  child: const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
          ),

          
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withCustomOpacity(0.8),
                    Colors.black.withCustomOpacity(0.5),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    if (isInterested)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withCustomOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                      ),
                  ],
                ),

                const Spacer(),

                
                Text(
                  event.restaurantName.toUpperCase(),
                  style: AppTextStyles.regularStyle.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),

                8.vertical,

                
                Text(
                  event.eventName,
                  style: AppTextStyles.headingStyle1.copyWith(
                    color: AppColors.whiteColor,
                    fontFamily: AppFonts.sandSemiBold,
                    fontSize: 24,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                16.vertical,

                
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withCustomOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        height: 16,
                        width: 16,
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                        AppAssets.locIcon,
                      ),
                    ),
                    12.horizontal,
                    Expanded(
                      child: Text(
                        event.eventLocation,
                        style: AppTextStyles.regularStyle.copyWith(
                          color: AppColors.whiteColor.withCustomOpacity(0.9),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                12.vertical,

                
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withCustomOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        height: 16,
                        width: 16,
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                        AppAssets.eventBold,
                      ),
                    ),
                    12.horizontal,
                    Expanded(
                      child: Text(
                        _formatDateTime(event.startTime),
                        style: AppTextStyles.regularStyle.copyWith(
                          color: AppColors.whiteColor.withCustomOpacity(0.9),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                20.vertical,

                
                if (!isInterested)
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.toggleInterest(event),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  color: AppColors.whiteColor,
                                  size: 18,
                                ),
                                8.horizontal,
                                Text(
                                  'I\'m Interested',
                                  style: AppTextStyles.regularStyle.copyWith(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withCustomOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_forward,
                                color: AppColors.whiteColor,
                                size: 18,
                              ),
                              8.horizontal,
                              Text(
                                'View Details',
                                style: AppTextStyles.regularStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
