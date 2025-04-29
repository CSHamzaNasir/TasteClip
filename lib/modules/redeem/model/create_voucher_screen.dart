import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/redeem/model/create_voucher_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';

class CreateVoucherScreen extends StatelessWidget {
  CreateVoucherScreen({super.key});

  final controller = Get.put(VoucherController());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.expireDateController.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(
              Icons.close,
              color: AppColors.textColor,
            ),
            backgroundColor: AppColors.transparent,
            elevation: 0,
            title: Text(
              "Create Voucher",
              style: AppTextStyles.boldBodyStyle.copyWith(
                color: AppColors.textColor,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.goldenColor,
                          )),
                      child: SvgPicture.asset(
                        AppAssets.voucherIcon,
                        height: 100,
                        width: 100,
                        colorFilter: ColorFilter.mode(
                          AppColors.btnUnSelectColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Voucher Discount",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.mainColor,
                      fontFamily: AppFonts.sandSemiBold,
                    ),
                  ),
                  AppFeild(
                    hintText: "Discount (e.g., 10%, \$5 off)",
                    hintTextColor: AppColors.btnUnSelectColor,
                    controller: controller.discountController,
                  ),
                  Text(
                    "Voucher Worth",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.mainColor,
                      fontFamily: AppFonts.sandSemiBold,
                    ),
                  ),
                  AppFeild(
                    controller: controller.worthController,
                    hintText: "Voucher Worth (e.g., \$20)",
                    hintTextColor: AppColors.btnUnSelectColor,
                  ),
                  Text(
                    "Expiry Date",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.mainColor,
                      fontFamily: AppFonts.sandSemiBold,
                    ),
                  ),
                  AppFeild(
                    suffixImage: AppAssets.eventBold,
                    onSuffixTap: () => _selectDate(context),
                    controller: controller.expireDateController,
                    hintText: "Expiry Date",
                    hintTextColor: AppColors.btnUnSelectColor,
                  ),
                  AppButton(
                      text: "Create Voucher",
                      onPressed: controller.createVoucher)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
