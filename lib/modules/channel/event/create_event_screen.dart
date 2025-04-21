import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/redeem/model/create_voucher_controller.dart';

class CreateEventScreen extends StatelessWidget {
  CreateEventScreen({super.key});

  final _controller = Get.put(VoucherController());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightColor,
      appBar: AppBar(
        title: const Text('Create Voucher'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                              _controller.createVoucher();
                            } else {
                              Get.snackbar('Error', 'Please fill all fields');
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: _controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text('Create Voucher'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
