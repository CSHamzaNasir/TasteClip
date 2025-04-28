import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/explore/detail/model/comment_model.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;

  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WatchFeedbackController>();
    comment.likes.contains(controller.currentUserId);
    final timeAgo = _getTimeAgo(comment.timestamp);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 17,
              backgroundImage: comment.userImage.isNotEmpty
                  ? CachedNetworkImageProvider(comment.userImage)
                  : null,
              child: comment.userImage.isEmpty
                  ? const Icon(Icons.person, size: 20)
                  : null,
            ),
            10.horizontal,
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.userName,
                        style: AppTextStyles.bodyStyle.copyWith(
                          fontFamily: AppFonts.sandBold,
                          color: AppColors.textColor.withCustomOpacity(.7),
                        ),
                      ),
                      Text(
                        comment.comment,
                        style: AppTextStyles.regularStyle.copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                      16.vertical,
                    ],
                  ),
                  Text(
                    timeAgo,
                    style: AppTextStyles.bodyStyle.copyWith(
                      fontSize: 12,
                      color: AppColors.textColor.withCustomOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (comment.replies.isNotEmpty) ...[
          10.vertical,
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              children: comment.replies
                  .map((reply) => CommentItem(
                        comment: reply,
                      ))
                  .toList(),
            ),
          ),
        ],
      ],
    );
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
