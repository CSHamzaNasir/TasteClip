import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/constant/app_colors.dart';

import 'cu_text_feedback_controller.dart';

class UserFeedbackScreen extends StatelessWidget {
  UserFeedbackScreen({super.key});
  final controller = Get.put(UserFeedbackController());

  @override
  Widget build(BuildContext context) {
    controller.fetchUserFeedback();

    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(title: Text("My Feedbacks")),
      body: Obx(() {
        if (controller.userFeedbackList.isEmpty) {
          return Center(child: Text("No feedback found"));
        }
        return ListView.builder(
          itemCount: controller.userFeedbackList.length,
          itemBuilder: (context, index) {
            var feedback = controller.userFeedbackList[index];

            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(feedback['restaurant_name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Branch: ${feedback['branch_name']}"),
                    Text("Feedback: ${feedback['feedback_text']}"),
                    Text("Rating: ${feedback['rating']}"),
                    Text("Date: ${feedback['created_at']}"),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
