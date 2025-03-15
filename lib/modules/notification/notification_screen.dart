import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/config/role_enum.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/notification/notification_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final controller = Get.put(NotificationController(role: UserRole.manager));

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: AppColors.transparent,
            title: Text("Notifications",
                style: AppTextStyles.boldBodyStyle.copyWith(
                  color: AppColors.textColor,
                )),
          ),
          body: Obx(() {
            if (controller.notificationList.isEmpty) {
              return Center(
                  child: CupertinoActivityIndicator(
                color: AppColors.textColor,
              ));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("You have 12 notifications today"),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.notificationList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        var notification = controller.notificationList[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.greyColor,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.red,
                                  ),
                                  6.horizontal,
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundImage:
                                        (notification['profileImage'] != null &&
                                                notification['profileImage']
                                                    .isNotEmpty)
                                            ? NetworkImage(
                                                notification['profileImage'])
                                            : null,
                                    child:
                                        (notification['profileImage'] == null ||
                                                notification['profileImage']
                                                    .isEmpty)
                                            ? const Icon(Icons.person, size: 25)
                                            : null,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notification['fullName'],
                                          style: AppTextStyles.regularStyle
                                              .copyWith(
                                            color: AppColors.mainColor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Upload the feedback",
                                          style:
                                              AppTextStyles.lightStyle.copyWith(
                                            color: AppColors.textColor,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  (notification['image_url'] != null &&
                                          notification['image_url'].isNotEmpty)
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            notification['image_url'],
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const SizedBox(
                                                width: 60,
                                                height: 60,
                                                child: Center(
                                                    child:
                                                        CupertinoActivityIndicator()),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(
                                              Icons.image_not_supported,
                                              size: 25,
                                            ),
                                          ),
                                        )
                                      : const Icon(Icons.image_not_supported,
                                          size: 25),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    "Image Feedback",
                                    style: AppTextStyles.lightStyle.copyWith(
                                      color: AppColors.mainColor,
                                      fontFamily: AppFonts.sandSemiBold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    color: AppColors.btnUnSelectColor,
                                    height: 15,
                                    width: 1,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    notification['created_at'],
                                    style: AppTextStyles.lightStyle.copyWith(
                                      color: AppColors.mainColor,
                                      fontFamily: AppFonts.sandSemiBold,
                                    ),
                                  ),
                                ],
                              )
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
        ),
      ),
    );
  }
}
