import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/explore/detail/components/comment_item.dart';
import 'package:tasteclip/modules/explore/detail/model/comment_model.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/review/Image/model/upload_feedback_model.dart';
import 'package:tasteclip/widgets/app_feild.dart';

class CommentsBottomSheet extends StatefulWidget {
  final String feedbackId;
  final VoidCallback? onCommentAdded;

  const CommentsBottomSheet({
    super.key,
    required this.feedbackId,
    this.onCommentAdded,
  });

  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: this,
      ),
    );
  }

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  final WatchFeedbackController _controller =
      Get.find<WatchFeedbackController>();
  late UploadFeedbackModel _feedback;
  final FocusNode _commentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadFeedback();
    _controller.addListener(_updateFeedback);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateFeedback);
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  void _loadFeedback() {
    _feedback = _controller.feedbacks.firstWhere(
      (f) => f.feedbackId == widget.feedbackId,
      orElse: () => UploadFeedbackModel(
        feedbackId: '',
        userId: '',
        restaurantName: '',
        branchName: '',
        description: '',
        rating: 0,
        category: '',
        createdAt: DateTime.now(),
        comments: [],
        branchId: '',
        billImageUrl: '',
      ),
    );
  }

  void _updateFeedback() {
    if (mounted) {
      setState(() {
        _loadFeedback();
      });
    }
  }

  Future<void> _addComment() async {
    if (_commentController.text.trim().isEmpty) return;

    await _controller.addComment(
      widget.feedbackId,
      _commentController.text.trim(),
    );
    _commentController.clear();

    if (widget.onCommentAdded != null) {
      widget.onCommentAdded!();
    }

    // ignore: use_build_context_synchronously
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.whiteColor.withCustomOpacity(0),
              AppColors.whiteColor.withCustomOpacity(0.30),
              AppColors.whiteColor.withCustomOpacity(.1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 0.2, 0.9],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Container(
                color: AppColors.whiteColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20)
                          .copyWith(top: 15),
                      child: Text(
                        "Comments (${_feedback.comments.length})",
                        style: AppTextStyles.boldBodyStyle.copyWith(
                            color: AppColors.textColor.withCustomOpacity(.8)),
                      ),
                    ),
                    20.vertical,
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: Get.height * 0.5,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        separatorBuilder: (context, index) => 10.vertical,
                        itemCount: _feedback.comments.length,
                        itemBuilder: (context, index) {
                          final commentData = _feedback.comments[index];
                          final comment = CommentModel.fromMap(
                              commentData as Map<String, dynamic>);
                          return CommentItem(
                            comment: comment,
                          );
                        },
                      ),
                    ),
                    _buildCommentInput(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentInput() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: AppFeild(
              controller: _commentController,
              onFieldSubmitted: (value) => _commentFocusNode,
              hintText: "Write a comment...",
              hintTextColor: AppColors.btnUnSelectColor,
            ),
          ),
          10.horizontal,
          GestureDetector(
            onTap: _addComment,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mainColor,
              ),
              child: SvgPicture.asset(
                AppAssets.sendIcon,
                colorFilter: const ColorFilter.mode(
                    AppColors.whiteColor, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
