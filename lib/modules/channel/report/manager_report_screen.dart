import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/channel/report/manager_report_detail_screen.dart';
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
            color: AppColors.whiteColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: StreamBuilder<List<UploadFeedbackModel>>(
        stream: _fetchReportsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: AppColors.mainColor.withCustomOpacity(0.7),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            );
          }

          final reports = snapshot.data ?? [];

          if (reports.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 80,
                    color: AppColors.primaryColor.withCustomOpacity(0.7),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No reports found',
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.textColor,
                      fontSize: 18,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'All manager reports will appear here',
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.textColor.withCustomOpacity(0.6),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final feedback = reports[index];

              return Column(
                children: feedback.report
                    .where(
                        (report) => report['sender'] == UserRole.manager.value)
                    .map((report) => _buildSingleReportCard(feedback, report))
                    .toList(),
              );
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
            return feedback.report
                .any((report) => report['sender'] == UserRole.manager.value);
          }).toList();
        });
  }

  Widget _buildSingleReportCard(
      UploadFeedbackModel feedback, Map<String, dynamic> report) {
    String firstLetter = report['reason'].toString().isNotEmpty
        ? report['reason'].toString()[0].toUpperCase()
        : 'R';

    String timeAgo = 'Recently';
    if (report['timestamp'] != null) {
      try {
        if (report['timestamp'] is Timestamp) {
          final timestamp = report['timestamp'] as Timestamp;
          final difference = DateTime.now().difference(timestamp.toDate());

          if (difference.inDays > 0) {
            timeAgo = '${difference.inDays}d ago';
          } else if (difference.inHours > 0) {
            timeAgo = '${difference.inHours}h ago';
          } else if (difference.inMinutes > 0) {
            timeAgo = '${difference.inMinutes}m ago';
          } else {
            timeAgo = 'Just now';
          }
        } else if (report['timestamp'] is String) {
          final dateTime = DateTime.tryParse(report['timestamp'] as String);
          if (dateTime != null) {
            final difference = DateTime.now().difference(dateTime);

            if (difference.inDays > 0) {
              timeAgo = '${difference.inDays}d ago';
            } else if (difference.inHours > 0) {
              timeAgo = '${difference.inHours}h ago';
            } else if (difference.inMinutes > 0) {
              timeAgo = '${difference.inMinutes}m ago';
            } else {
              timeAgo = 'Just now';
            }
          }
        }
      } catch (e) {
        timeAgo = 'Recently';
      }
    }

    return GestureDetector(
      onTap: () => Get.to(() => ManagerReportDetailScreen(
            feedback: feedback,
          )),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.mainColor.withCustomOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: AppColors.greyColor.withCustomOpacity(0.5),
            width: 1,
          ),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    firstLetter,
                    style: AppTextStyles.boldBodyStyle.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${report['reason']}',
                            style: AppTextStyles.regularStyle.copyWith(
                              fontFamily: AppFonts.sandBold,
                              color: AppColors.textColor,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lightColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            timeAgo,
                            style: AppTextStyles.regularStyle.copyWith(
                              color: AppColors.mainColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      feedback.branchName,
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.textColor.withCustomOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildInfoChip(
                          Icons.location_on_outlined,
                          feedback.restaurantName,
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.greyColor.withCustomOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: AppColors.mainColor,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppTextStyles.regularStyle.copyWith(
              color: AppColors.textColor.withCustomOpacity(0.7),
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
