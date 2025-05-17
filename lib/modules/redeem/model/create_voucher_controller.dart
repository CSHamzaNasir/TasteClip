import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/modules/redeem/model/voucher_model.dart';
import 'package:tasteclip/modules/feedback/model/upload_feedback_model.dart';

class VoucherController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;
  final discountController = TextEditingController();
  final worthController = TextEditingController();
  final expireDateController = TextEditingController();
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final vouchers = <VoucherModel>[].obs;

  @override
  void onClose() {
    discountController.dispose();
    worthController.dispose();
    expireDateController.dispose();
    super.onClose();
  }

  Future<void> createVoucher() async {
    try {
      isLoading.value = true;

      final user = _auth.currentUser;
      if (user == null) {
        throw "User not authenticated";
      }

      final restaurantData = await _findRestaurantAndBranch(user.uid);
      if (restaurantData == null) {
        throw "Restaurant or branch not found";
      }

      final voucher = VoucherModel(
        branchId: restaurantData['branchId'],
        branchName: restaurantData['branchName'],
        branchImage: restaurantData['branchImage'],
        discount: discountController.text.trim(),
        expireDate: expireDateController.text.trim(),
        restaurantName: restaurantData['restaurantName'],
        restaurantId: restaurantData['restaurantId'],
        worth: worthController.text.trim(),
      );

      await _firestore.collection('vouchers').add(voucher.toMap());

      Get.back();
      Get.snackbar('Success', 'Voucher created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchVouchers() async {
    try {
      isLoading.value = true;
      final querySnapshot = await _firestore.collection('vouchers').get();

      vouchers.assignAll(querySnapshot.docs.map((doc) {
        return VoucherModel.fromMap(doc.data(), doc.id);
      }).toList());
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch vouchers: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>?> _findRestaurantAndBranch(
      String branchId) async {
    final restaurants = await _firestore.collection('restaurants').get();

    for (var restaurantDoc in restaurants.docs) {
      final branches = restaurantDoc['branches'] as List;

      for (var branch in branches) {
        if (branch['branchId'] == branchId) {
          return {
            'branchId': branchId,
            'branchName': branch['branchAddress'] ?? 'Branch',
            'branchImage': branch['branchThumbnail'] ?? '',
            'restaurantName': restaurantDoc['restaurantName'],
            'restaurantId': restaurantDoc.id,
          };
        }
      }
    }
    return null;
  }

  Future<void> redeemVoucher(
      VoucherModel voucher, UploadFeedbackModel feedback) async {
    try {
      isLoading.value = true;
      final user = _auth.currentUser;
      if (user == null) {
        throw "User not authenticated";
      }

      final requiredCoins = int.tryParse(voucher.worth) ?? 0;
      if (feedback.tasteCoin < requiredCoins) {
        throw "Insufficient coins";
      }

      if (voucher.buyers.containsKey(user.uid)) {
        throw "You've already redeemed this voucher";
      }

      await _firestore.runTransaction((transaction) async {
        final voucherRef = _firestore.collection('vouchers').doc(voucher.id);
        transaction.update(voucherRef, {
          'buyers.${user.uid}': FieldValue.arrayUnion([
            {
              'redeemedAt': DateTime.now().toIso8601String(),
              'coinsUsed': requiredCoins,
            }
          ]),
        });

        final feedbackRef =
            _firestore.collection('feedback').doc(feedback.feedbackId);
        transaction.update(feedbackRef, {
          'tasteCoin': FieldValue.increment(-requiredCoins),
        });
      });

      await fetchVouchers();
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
