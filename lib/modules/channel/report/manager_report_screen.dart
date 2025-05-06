import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/review/Image/model/upload_feedback_model.dart';

class ManagerReportsScreen extends StatelessWidget {
  const ManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Reports',
          style: AppTextStyles.boldBodyStyle.copyWith(
            color: AppColors.textColor,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.transparent,
      ),
      body: StreamBuilder<List<UploadFeedbackModel>>(
        stream: _fetchReportsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final reports = snapshot.data ?? [];

          if (reports.isEmpty) {
            return const Center(child: Text('No reports found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final feedback = reports[index];
              return _buildReportCard(feedback);
            },
          );
        },
      ),
    );
  }

  Stream<List<UploadFeedbackModel>> _fetchReportsStream() {
    return FirebaseFirestore.instance
        .collection('feedback')
        .where('report', isNotEqualTo: [])
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return UploadFeedbackModel.fromMap(doc.data());
          }).where((feedback) {
            return feedback.report.any(
                (report) => report['sender'] == UserRole.manager.toString());
          }).toList();
        });
  }

  Widget _buildReportCard(UploadFeedbackModel feedback) {
    final managerReports = feedback.report
        .where((report) => report['sender'] == UserRole.manager.toString())
        .toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      color: Color(0xffF9FAFB),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...managerReports.map((report) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reason: ${report['reason']}',
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Status: ${report['status']}',
                      style: AppTextStyles.regularStyle.copyWith(
                        color: _getStatusColor(report['status']),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Reported on: ${_formatDate(report['timestamp'])}',
                      style: AppTextStyles.lightStyle.copyWith(
                        color: AppColors.textColor.withCustomOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       feedback.restaurantName,
        //       style: AppTextStyles.boldBodyStyle.copyWith(
        //         color: AppColors.whiteColor,
        //       ),
        //     ),
        //     const SizedBox(height: 8),
        //     Text(
        //       feedback.branchName,
        //       style: AppTextStyles.regularStyle.copyWith(
        //         color: AppColors.whiteColor.withCustomOpacity(0.8),
        //       ),
        //     ),
        //     const SizedBox(height: 16),
        //     Text(
        //       'Feedback: ${feedback.description}',
        //       style: AppTextStyles.regularStyle.copyWith(
        //         color: AppColors.whiteColor,
        //       ),
        //       maxLines: 2,
        //       overflow: TextOverflow.ellipsis,
        //     ),
        //     const SizedBox(height: 16),
        //     const Divider(color: AppColors.btnUnSelectColor),
        //     const SizedBox(height: 8),
        //     Text(
        //       'Manager Reports (${managerReports.length})',
        //       style: AppTextStyles.boldBodyStyle.copyWith(
        //         color: AppColors.whiteColor,
        //         fontSize: 16,
        //       ),
        //     ),
        //     const SizedBox(height: 8),
        //     ...managerReports.map((report) {
        //       return Padding(
        //         padding: const EdgeInsets.only(bottom: 12),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               'Reason: ${report['reason']}',
        //               style: AppTextStyles.regularStyle.copyWith(
        //                 color: AppColors.whiteColor,
        //               ),
        //             ),
        //             const SizedBox(height: 4),
        //             Text(
        //               'Status: ${report['status']}',
        //               style: AppTextStyles.regularStyle.copyWith(
        //                 color: _getStatusColor(report['status']),
        //               ),
        //             ),
        //             const SizedBox(height: 4),
        //             Text(
        //               'Reported on: ${_formatDate(report['timestamp'])}',
        //               style: AppTextStyles.lightStyle.copyWith(
        //                 color: AppColors.whiteColor.withCustomOpacity(0.6),
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     }),
        //     if (feedback.billImageUrl.isNotEmpty)
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           const SizedBox(height: 16),
        //           const Divider(color: AppColors.btnUnSelectColor),
        //           const SizedBox(height: 8),
        //           Text(
        //             'Bill Image',
        //             style: AppTextStyles.boldBodyStyle.copyWith(
        //               color: AppColors.whiteColor,
        //             ),
        //           ),
        //           const SizedBox(height: 8),
        //           GestureDetector(
        //             onTap: () {
        //               Get.dialog(
        //                 Dialog(
        //                   backgroundColor: Colors.transparent,
        //                   child: CachedNetworkImage(
        //                     imageUrl: feedback.billImageUrl,
        //                     fit: BoxFit.contain,
        //                   ),
        //                 ),
        //               );
        //             },
        //             child: CachedNetworkImage(
        //               imageUrl: feedback.billImageUrl,
        //               height: 100,
        //               width: double.infinity,
        //               fit: BoxFit.cover,
        //               placeholder: (context, url) => const Center(
        //                 child: CircularProgressIndicator(),
        //               ),
        //               errorWidget: (context, url, error) => const Icon(
        //                 Icons.error,
        //                 color: Colors.red,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //   ],
        // ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return AppColors.whiteColor;
    }
  }

  String _formatDate(String timestamp) {
    try {
      final date = DateTime.parse(timestamp);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    } catch (e) {
      return timestamp;
    }
  }
}
