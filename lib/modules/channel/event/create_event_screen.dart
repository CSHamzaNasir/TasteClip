

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/channel/event/create_event_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_feild.dart';

class CreateEventScreen extends StatelessWidget {
  CreateEventScreen({super.key});

  final _controller = Get.put(EventController());
  final ImagePicker _picker = ImagePicker();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: isStartDate ? DateTime.now() : DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      if (isStartDate) {
        _controller.startDateController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      } else {
        _controller.expireDateController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _controller.selectedImagePath.value = image.path;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.transparent,
          elevation: 0,
          title: Text(
            "Create Event",
            style: AppTextStyles.boldBodyStyle.copyWith(
              color: AppColors.textColor,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.textColor),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Event Image",
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                AppColors.primaryColor.withCustomOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: _controller.selectedImagePath.value.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate_outlined,
                                    size: 40,
                                    color: AppColors.primaryColor,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Tap to upload event image',
                                    style: AppTextStyles.regularStyle.copyWith(
                                      color: AppColors.btnUnSelectColor,
                                    ),
                                  ),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(_controller.selectedImagePath.value),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    )),
                const SizedBox(height: 20),
                Text(
                  "Event Details",
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 12),
                AppFeild(
                  controller: _controller.eventNameController,
                  hintText: "Event Name",
                  hintTextColor: AppColors.btnUnSelectColor,
                ),
                const SizedBox(height: 12),
                AppFeild(
                  controller: _controller.eventLocationController,
                  hintText: "Event Location",
                  hintTextColor: AppColors.btnUnSelectColor,
                ),
                const SizedBox(height: 12),
                AppFeild(
                  controller: _controller.eventDescriptionController,
                  hintText: "Event Description",
                  hintTextColor: AppColors.btnUnSelectColor,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller.startDateController,
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          labelStyle: TextStyle(color: AppColors.primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.mainColor),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today,
                                color: AppColors.primaryColor),
                            onPressed: () => _selectDate(context, true),
                          ),
                        ),
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _controller.startTimeController,
                        decoration: InputDecoration(
                          labelText: 'Start Time',
                          labelStyle: TextStyle(color: AppColors.primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.mainColor),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.access_time,
                                color: AppColors.primaryColor),
                            onPressed: () async {
                              final TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                
                                _controller.startTimeController.text =
                                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                              }
                            },
                          ),
                        ),
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller.expireDateController,
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          labelStyle: TextStyle(color: AppColors.primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.mainColor),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today,
                                color: AppColors.primaryColor),
                            onPressed: () => _selectDate(context, false),
                          ),
                        ),
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _controller.endTimeController,
                        decoration: InputDecoration(
                          labelText: 'End Time',
                          labelStyle: TextStyle(color: AppColors.primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.mainColor),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.access_time,
                                color: AppColors.primaryColor),
                            onPressed: () async {
                              final TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                _controller.endTimeController.text =
                                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                              }
                            },
                          ),
                        ),
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Voucher Details",
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 12),
                AppFeild(
                  controller: _controller.discountController,
                  hintText: "Discount (e.g., 10%, \$5 off)",
                  hintTextColor: AppColors.btnUnSelectColor,
                ),
                const SizedBox(height: 12),
                AppFeild(
                  controller: _controller.worthController,
                  hintText: "Voucher Worth (e.g., \$20)",
                  hintTextColor: AppColors.btnUnSelectColor,
                ),
                const SizedBox(height: 24),
                Obx(() => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _controller.isLoading.value
                            ? null
                            : () {
                                if (_controller.validateFields()) {
                                  _controller.createEventWithVoucher();
                                } else {
                                  Get.snackbar(
                                    'Error',
                                    'Please fill all required fields',
                                    backgroundColor: AppColors.lightColor,
                                    colorText: AppColors.textColor,
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: _controller.isLoading.value
                            ? const CupertinoActivityIndicator(
                                color: Colors.white)
                            : Text(
                                'Create Event',
                                style: AppTextStyles.bodyStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
