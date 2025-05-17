import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/channel/modules/report/service/firebase_storage_service.dart';
import 'package:tasteclip/modules/feedback/model/upload_feedback_model.dart';

class ManagerReportDetailScreen extends StatefulWidget {
  final UploadFeedbackModel? feedback;

  const ManagerReportDetailScreen({super.key, this.feedback});

  @override
  State<ManagerReportDetailScreen> createState() =>
      _ManagerReportDetailScreenState();
}

class _ManagerReportDetailScreenState extends State<ManagerReportDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();
  bool isUploading = false;

  List<Map<String, dynamic>> allMessages = [];
  Map<String, dynamic> pinnedMessage = {
    'type': 'pinned',
    'content':
        'Please leave your restaurant bill image here. We will check and notify you.',
  };

  @override
  void initState() {
    super.initState();
    if (widget.feedback != null) {
      allMessages = [
        {
          'type': 'info',
          'content': 'Feedback started',
        },
        {
          'type': 'customer',
          'content': widget.feedback!.description,
          'imageUrl': widget.feedback!.billImageUrl.isNotEmpty
              ? widget.feedback!.billImageUrl
              : null,
        },
        ...widget.feedback!.report.map((report) {
          return {
            'type': report['sender'] == UserRole.manager.value
                ? 'manager'
                : 'customer',
            'content': report['reason'] ?? '',
            'imageUrl': report['imageUrl'],
          };
        }),
      ];
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _uploadManagerBill() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      setState(() => isUploading = true);

      final firebaseStorageService = FirebaseStorageService();
      final String imageUrl = await firebaseStorageService.uploadFile(
        filePath: image.path,
        storagePath: 'manager_bills/${DateTime.now().millisecondsSinceEpoch}',
      );

      final doc = await _firestore
          .collection('feedback')
          .doc(widget.feedback?.feedbackId)
          .get();

      List<Map<String, dynamic>> reports =
          List<Map<String, dynamic>>.from(doc.data()?['report'] ?? []);

      int managerReportIndex = reports.indexWhere(
        (report) => report['sender'] == UserRole.manager.value,
      );

      if (managerReportIndex != -1) {
        reports[managerReportIndex]['imageUrl'] = imageUrl;
      } else {
        reports.add({
          'imageUrl': imageUrl,
          'sender': UserRole.manager.value,
          'status': 'pending',
          'reason': '',
        });
      }

      await _firestore
          .collection('feedback')
          .doc(widget.feedback?.feedbackId)
          .update({
        'report': reports,
      });

      setState(() {
        if (managerReportIndex != -1) {
          int uiIndex = allMessages.indexWhere(
            (msg) => msg['type'] == 'manager' && msg['imageUrl'] == null,
          );
          if (uiIndex != -1) {
            allMessages[uiIndex]['imageUrl'] = imageUrl;
          } else {
            allMessages.add({
              'type': 'manager',
              'content': '',
              'imageUrl': imageUrl,
            });
          }
        } else {
          allMessages.add({
            'type': 'manager',
            'content': '',
            'imageUrl': imageUrl,
          });
        }
        isUploading = false;
      });

      _scrollToBottom();
    } catch (e) {
      setState(() => isUploading = false);
      Get.snackbar('Error', 'Failed to upload bill: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.lightColor,
        appBar: AppBar(
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.feedback?.restaurantName ?? 'Unknown Restaurant',
                style: AppTextStyles.boldBodyStyle.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                ),
              ),
              Text(
                widget.feedback?.branchName ?? 'Unknown Branch',
                style: AppTextStyles.regularStyle.copyWith(
                  color: AppColors.whiteColor.withCustomOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.mainColor,
          foregroundColor: AppColors.whiteColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
            onPressed: () => Get.back(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline, color: AppColors.whiteColor),
              onPressed: () {
                Get.dialog(
                  Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Feedback Details',
                            style: AppTextStyles.boldBodyStyle.copyWith(
                              fontSize: 18,
                              color: AppColors.mainColor,
                            ),
                          ),
                          const Divider(),
                          Text(
                            'Restaurant: ${widget.feedback?.restaurantName ?? 'Unknown'}',
                            style: AppTextStyles.regularStyle,
                          ),
                          8.vertical,
                          Text(
                            'Branch: ${widget.feedback?.branchName ?? 'Unknown'}',
                            style: AppTextStyles.regularStyle,
                          ),
                          16.vertical,
                          Center(
                            child: TextButton(
                              onPressed: () => Get.back(),
                              child: Text(
                                'Close',
                                style: TextStyle(color: AppColors.mainColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.mainColor.withCustomOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.mainColor.withCustomOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.push_pin, color: AppColors.mainColor, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      pinnedMessage['content'],
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: allMessages.length,
                itemBuilder: (context, index) {
                  final message = allMessages[index];
                  final isManager = message['type'] == 'manager';
                  final isInfo = message['type'] == 'info';

                  if (isInfo) {
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.greyColor.withCustomOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message['content'],
                          style: AppTextStyles.lightStyle.copyWith(
                            fontSize: 12,
                            color: AppColors.textColor.withCustomOpacity(0.7),
                          ),
                        ),
                      ),
                    );
                  }

                  return Align(
                    alignment: isManager
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isManager
                            ? AppColors.mainColor
                            : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(16).copyWith(
                          bottomRight:
                              isManager ? const Radius.circular(0) : null,
                          bottomLeft:
                              !isManager ? const Radius.circular(0) : null,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withCustomOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (message['content']?.isNotEmpty ?? false)
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                message['content'] ?? '',
                                style: AppTextStyles.regularStyle.copyWith(
                                  color: isManager
                                      ? AppColors.whiteColor
                                      : AppColors.textColor,
                                ),
                              ),
                            ),
                          if (message['imageUrl'] != null)
                            GestureDetector(
                              onTap: () => _showFullImage(message['imageUrl']),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.3,
                                  ),
                                  child: CustomImageView(
                                    imagePath: message['imageUrl'],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withCustomOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: isUploading
                  ? const Center(
                      child: Text("Uploading..."),
                    )
                  : ElevatedButton.icon(
                      icon:
                          const Icon(Icons.image, color: AppColors.whiteColor),
                      label: Text(
                        'Upload Bill Image',
                        style: AppTextStyles.regularStyle.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onPressed: _uploadManagerBill,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFullImage(String imageUrl) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                color: Colors.black.withCustomOpacity(0.7),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Hero(
              tag: imageUrl,
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 3.0,
                child: CustomImageView(
                  imagePath: imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close,
                    color: AppColors.whiteColor, size: 30),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class CustomImageView extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomImageView({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imagePath,
      height: height,
      width: width,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ??
            Container(
              height: height ?? 200,
              width: width ?? double.infinity,
              color: AppColors.greyColor.withCustomOpacity(0.3),
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
      },
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ??
          Container(
            height: height ?? 200,
            width: width ?? double.infinity,
            color: AppColors.greyColor.withCustomOpacity(0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error,
                    color: AppColors.textColor.withCustomOpacity(0.5)),
                const SizedBox(height: 8),
                Text(
                  'Image not available',
                  style: TextStyle(
                      color: AppColors.textColor.withCustomOpacity(0.5)),
                ),
              ],
            ),
          ),
    );
  }
}
