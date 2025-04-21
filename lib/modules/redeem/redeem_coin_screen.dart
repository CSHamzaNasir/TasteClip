import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/redeem/model/create_voucher_controller.dart';
import 'package:tasteclip/modules/redeem/model/voucher_model.dart';
import 'package:tasteclip/utils/app_alert.dart';

import '../review/Image/model/upload_feedback_model.dart';

// ignore: must_be_immutable
class RedeemCoinScreen extends StatelessWidget {
  UploadFeedbackModel feedback;
  final VoucherController _controller = Get.put(VoucherController());
  final List<Color> voucherColors = [
    const Color(0xff039557),
    const Color(0xff0150AD),
    const Color(0xffCE373C),
    const Color(0xff20120F),
  ];

  RedeemCoinScreen({super.key, required this.feedback}) {
    _controller.fetchVouchers();
  }

  @override
  Widget build(BuildContext context) {
    log(feedback.feedbackId.toString());

    return Scaffold(
      backgroundColor: AppColors.whiteColor.withCustomOpacity(.9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
          onPressed: () => Get.back(),
        ),
        title: Text('Vouchers',
            style: AppTextStyles.boldBodyStyle
                .copyWith(color: AppColors.whiteColor)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.whiteColor),
            onPressed: _controller.fetchVouchers,
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_controller.errorMessage.value,
                    style: AppTextStyles.regularStyle
                        .copyWith(color: const Color(0xFFFF0C0C))),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _controller.fetchVouchers,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (_controller.vouchers.isEmpty) {
          return Center(
            child: Text('No vouchers available',
                style: AppTextStyles.regularStyle
                    .copyWith(color: AppColors.textColor)),
          );
        }

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              height: 70,
              color: AppColors.mainColor,
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.voucherIcon,
                    colorFilter: ColorFilter.mode(
                      AppColors.whiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text("Vouchers",
                      style: AppTextStyles.headingStyle
                          .copyWith(color: AppColors.whiteColor, fontSize: 24)),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _controller.fetchVouchers,
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: _controller.vouchers.length,
                  itemBuilder: (context, index) {
                    final voucher = _controller.vouchers[index];
                    return _buildVoucherCard(voucher, index);
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildVoucherCard(VoucherModel voucher, int index) {
    final color = voucherColors[index % voucherColors.length];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.textColor.withCustomOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                if (voucher.branchImage.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(
                      voucher.branchImage,
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.store, color: AppColors.whiteColor),
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        voucher.branchName,
                        style: AppTextStyles.boldBodyStyle.copyWith(
                          color: AppColors.whiteColor,
                          fontFamily: AppFonts.sandSemiBold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        voucher.restaurantName,
                        style: AppTextStyles.regularStyle.copyWith(
                          color: AppColors.whiteColor.withCustomOpacity(0.9),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${voucher.discount}% OFF',
                        style: AppTextStyles.headingStyle1
                            .copyWith(color: AppColors.textColor)),
                    const SizedBox(height: 6),
                    Text('Valid Until: ${voucher.expireDate}',
                        style: AppTextStyles.lightStyle
                            .copyWith(color: AppColors.textColor)),
                  ],
                ),
                Obx(() {
                  final isRedeeming = _controller.isLoading.value;
                  return GestureDetector(
                    onTap: isRedeeming
                        ? null
                        : () async {
                            if (feedback.branchName != voucher.branchName) {
                              AppAlerts.showSnackbar(
                                customTitle: 'Sorry',
                                isSuccess: false,
                                message:
                                    "You are not eligible for this voucher",
                              );
                              return;
                            }

                            final requiredCoins =
                                int.tryParse(voucher.worth) ?? 0;
                            final userCoins = feedback.tasteCoin;

                            if (userCoins < requiredCoins) {
                              AppAlerts.showSnackbar(
                                customTitle: 'Insufficient Coins',
                                isSuccess: false,
                                message:
                                    "You need ${requiredCoins - userCoins} more coins to redeem this voucher",
                              );
                              return;
                            }

                            if (voucher.buyers.containsKey(
                                _controller.auth.currentUser?.uid)) {
                              AppAlerts.showSnackbar(
                                customTitle: 'Already Redeemed',
                                isSuccess: false,
                                message: "You've already redeemed this voucher",
                              );
                              return;
                            }

                            final confirmed = await showDialog<bool>(
                                  context: Get.context!,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Redeem Voucher'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${voucher.discount}% OFF at ${voucher.branchName}'),
                                        const SizedBox(height: 12),
                                        Text(
                                            'This will cost you: ${voucher.worth} Taste Coins'),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Your current balance: $userCoins coins'),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Remaining balance: ${userCoins - requiredCoins} coins',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 16),
                                        const Text('Do you want to proceed?'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Get.back(result: false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Get.back(result: true),
                                        child: const Text(
                                          'Confirm',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                    ],
                                  ),
                                ) ??
                                false;

                            if (confirmed) {
                              try {
                                await _controller.redeemVoucher(
                                    voucher, feedback);

                                feedback = feedback.copyWith(
                                  tasteCoin: userCoins - requiredCoins,
                                );

                                AppAlerts.showSnackbar(
                                  customTitle: 'Success',
                                  isSuccess: true,
                                  message:
                                      "Voucher redeemed successfully! ${voucher.discount}% OFF at ${voucher.branchName}",
                                );

                                _controller.fetchVouchers();
                              } catch (e) {
                                AppAlerts.showSnackbar(
                                  customTitle: 'Error',
                                  isSuccess: false,
                                  message: e.toString(),
                                );
                              }
                            }
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: isRedeeming
                            ? AppColors.textColor.withCustomOpacity(0.5)
                            : AppColors.mainColor,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Redeem ${voucher.worth}",
                            style: AppTextStyles.regularStyle.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                          const SizedBox(width: 6),
                          SvgPicture.asset(
                            AppAssets.coinLogo,
                            height: 20,
                            width: 20,
                            colorFilter: ColorFilter.mode(
                              isRedeeming
                                  ? AppColors.whiteColor.withCustomOpacity(0.7)
                                  : AppColors.whiteColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
