import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/channel/event/create_event_controller.dart';

class CreateEventScreen extends StatelessWidget {
  CreateEventScreen({super.key});

  final _controller = Get.put(EventController());
  final ImagePicker _picker = ImagePicker();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      _controller.expireDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
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
    return Scaffold(
      backgroundColor: AppColors.lightColor,
      appBar: AppBar(
        title: const Text('Create Event/Voucher'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Event Image Upload
              Obx(() => GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: _controller.selectedImagePath.value.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add_a_photo, size: 40),
                                SizedBox(height: 8),
                                Text('Upload Event Image'),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(_controller.selectedImagePath.value),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  )),
              const SizedBox(height: 16),

              // Event Name
              TextFormField(
                controller: _controller.eventNameController,
                decoration: const InputDecoration(
                  labelText: 'Event Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Event Location
              TextFormField(
                controller: _controller.eventLocationController,
                decoration: const InputDecoration(
                  labelText: 'Event Location',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Event Description
              TextFormField(
                controller: _controller.eventDescriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Event Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Start Time
              TextFormField(
                controller: _controller.startTimeController,
                decoration: InputDecoration(
                  labelText: 'Start Time',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        _controller.startTimeController.text =
                            // ignore: use_build_context_synchronously
                            time.format(context);
                      }
                    },
                  ),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 16),

              // End Time
              TextFormField(
                controller: _controller.endTimeController,
                decoration: InputDecoration(
                  labelText: 'End Time',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        _controller.endTimeController.text =
                            // ignore: use_build_context_synchronously
                            time.format(context);
                      }
                    },
                  ),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 16),

              // Voucher Fields
              TextFormField(
                controller: _controller.discountController,
                decoration: const InputDecoration(
                  labelText: 'Discount (e.g., 10%, \$5 off)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter discount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controller.worthController,
                decoration: const InputDecoration(
                  labelText: 'Voucher Worth (e.g., \$20)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter voucher worth';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controller.expireDateController,
                decoration: InputDecoration(
                  labelText: 'Expiry Date',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select expiry date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Obx(() => ElevatedButton(
                    onPressed: _controller.isLoading.value
                        ? null
                        : () {
                            if (_controller
                                    .discountController.text.isNotEmpty &&
                                _controller.worthController.text.isNotEmpty &&
                                _controller
                                    .expireDateController.text.isNotEmpty) {
                              _controller.createEventWithVoucher();
                            } else {
                              Get.snackbar('Error', 'Please fill all fields');
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: _controller.isLoading.value
                        ? const CupertinoActivityIndicator()
                        : const Text('Create Event with Voucher'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
