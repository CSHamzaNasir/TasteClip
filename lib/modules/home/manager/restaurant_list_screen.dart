import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/modules/home/manager/restaurant_list_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RestaurantListController());

    return AppBackground(
      isLight: true,
      child: Scaffold(
        body: StreamBuilder(
          stream: controller.getApprovedManagers(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text("No approved managers available"));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  32.vertical,
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      16.horizontal,
                      SvgPicture.asset(
                        AppAssets.filterIcon,
                        height: 50,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var manager = snapshot.data!.docs[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.whiteColor,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                AppAssets.cheeziousLogo,
                                height: 70,
                              ),
                              16.horizontal,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    manager["restaurant_name"],
                                    style: AppTextStyles.boldBodyStyle.copyWith(
                                      fontFamily: AppFonts.sandSemiBold,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                  Text(
                                    manager['branch_address'],
                                    style: AppTextStyles.lightStyle.copyWith(
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                  Text(
                                    "23 review uploaded",
                                    style: AppTextStyles.lightStyle.copyWith(
                                        color: AppColors.mainColor
                                            .withOpacity(.6)),
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
          },
        ),
      ),
    );
  }
}
