import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/channel/event/create_event_controller.dart';
import 'package:tasteclip/modules/channel/event/event_detail/event_detail_screen.dart';
import 'package:tasteclip/modules/channel/event/model/event_model.dart';

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
        title: Text(
          'Events',
          style: AppTextStyles.headingStyle1.copyWith(
              color: AppColors.textColor, fontFamily: AppFonts.sandBold),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (controller.event.isEmpty) {
          return const Center(child: Text('No events found'));
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectedTab.value = 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedTab.value == 0
                                  ? AppColors.mainColor
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Interested",
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: _selectedTab.value == 0
                                  ? AppColors.mainColor
                                  : AppColors.textColor.withCustomOpacity(0.5),
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
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedTab.value == 1
                                  ? AppColors.mainColor
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "All Events",
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: _selectedTab.value == 1
                                  ? AppColors.mainColor
                                  : AppColors.textColor.withCustomOpacity(0.5),
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
                    child: Text(
                      _selectedTab.value == 0
                          ? 'No interested events'
                          : 'No events to show',
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

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventController>();

    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.mainColor.withCustomOpacity(.2),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: event.branchImage,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CupertinoActivityIndicator()),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withCustomOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  event.eventName,
                  style: AppTextStyles.headingStyle1.copyWith(
                    color: AppColors.whiteColor,
                    fontFamily: AppFonts.sandSemiBold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                8.vertical,
                Row(
                  spacing: 8,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withCustomOpacity(.2),
                      ),
                      child: SvgPicture.asset(
                        height: 18,
                        width: 18,
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                        AppAssets.locIcon,
                      ),
                    ),
                    Text(event.eventLocation,
                        style: AppTextStyles.regularStyle
                            .copyWith(color: AppColors.whiteColor))
                  ],
                ),
                8.vertical,
                Row(
                  spacing: 8,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withCustomOpacity(.2),
                      ),
                      child: SvgPicture.asset(
                        height: 18,
                        width: 18,
                        fit: BoxFit.cover,
                        AppAssets.eventBold,
                      ),
                    ),
                    Text(event.startTime.toString(),
                        style: AppTextStyles.regularStyle
                            .copyWith(color: AppColors.whiteColor))
                  ],
                ),
                if (!isInterested) ...[
                  16.vertical,
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => controller.toggleInterest(event),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Interested',
                          style: AppTextStyles.regularStyle.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
