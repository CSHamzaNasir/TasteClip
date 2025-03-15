import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/modules/home/branches/branch_detail/branch_detail_controller.dart';
import 'package:tasteclip/modules/home/branches/branch_detail/components/filter.dart';
import 'package:tasteclip/widgets/app_background.dart';

class BranchDetailScreen extends StatelessWidget {
  BranchDetailScreen({super.key});
  final controller = Get.put(BranchDetailController());
  @override
  Widget build(BuildContext context) {
    return AppBackground(
        isLight: true,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [Filter(controller: controller)],
            ),
          ),
        ));
  }
}
