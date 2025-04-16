// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tasteclip/config/extensions/space_extensions.dart';
// import 'package:tasteclip/core/constant/app_colors.dart';
// import 'package:tasteclip/core/constant/app_fonts.dart';

// import '../../../config/app_text_styles.dart';
// import '../watch_feedback_controller.dart';

// class TopFilter extends StatelessWidget {
//   const TopFilter({
//     super.key,
//     required this.controller,
//   });

//   final WatchFeedbackController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Obx(() => Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: List.generate(controller.filters.length, (index) {
//               bool isSelected = controller.selectedTopFilter.value == index;
//               return GestureDetector(
//                 onTap: () => controller.changeFilter(index),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       controller.filters[index],
//                       style: AppTextStyles.bodyStyle.copyWith(
//                         fontFamily: isSelected
//                             ? AppFonts.sandBold
//                             : AppFonts.sandMedium,
//                         color: isSelected
//                             ? AppColors.textColor
//                             : AppColors.textColor.withCustomOpacity(0.7),
//                       ),
//                     ),
//                     4.vertical,
//                     if (isSelected)
//                       Container(
//                         width: 20,
//                         height: 3,
//                         decoration: BoxDecoration(
//                           color: AppColors.mainColor,
//                           borderRadius: BorderRadius.circular(2),
//                         ),
//                       ),
//                   ],
//                 ),
//               );
//             }),
//           )),
//     );
//   }
// }
