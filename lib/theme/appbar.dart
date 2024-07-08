import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/theme/text_style.dart';

class AppBars {
  static PreferredSizeWidget authAppbar() {
    return AppBar(
      backgroundColor: lightColor,
      leading: GestureDetector(
        onTap: () => Get.toNamed('/role'),
        child: Container(
          height: Get.height * 0.06,
          width: Get.height * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: secondaryColor,
          ),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({
//     super.key,
//     this.title,
//     this.action1IconButton,
//     this.customBackButton,
//   });
//   final String? title;
//   final Widget? action1IconButton;
//   final Widget? customBackButton;
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: true,
//       title: Text(
//         title ?? "",
//         style: const TextStyle(
//             fontSize: 16,
//             fontWeight: AppFontWeight.fontWeight600,
//             fontFamily: AppFontFamily.poppinsMedium),
//       ),
//       elevation: 0.0,
//       leadingWidth: 70,
//       backgroundColor: AppColors.transparent,
//       leading: Padding(
//           padding: const EdgeInsets.all(10),
//           child: customBackButton ?? const GoBackBtn()),
//       actions: [
//         if (action1IconButton != null)
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: action1IconButton!,
//           )
//       ],
//     );
//   }
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }