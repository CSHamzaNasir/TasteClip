import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

import '../../auth/manager_auth/model/channel_data.dart';

class ChannelProfileController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference restaurantsCollection =
      FirebaseFirestore.instance.collection('manager_credentials');
  Rx<ChannelDataModel?> channelData = Rx<ChannelDataModel?>(null);
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchManagerData();
  }

  Future<void> fetchManagerData() async {
    try {
      isLoading.value = true;
      String restaurantId = FirebaseAuth.instance.currentUser?.uid ?? '';
      DocumentSnapshot restaurantDoc =
          await restaurantsCollection.doc(restaurantId).get();

      if (restaurantDoc.exists) {
        channelData.value = ChannelDataModel.fromMap(
            restaurantDoc.data() as Map<String, dynamic>);
      } else {
        Get.snackbar('Error', 'Manager data not found.');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void goToRoleScreen() {
    Get.toNamed(AppRouter.roleScreen);
  }

  void goToEditScreen() {
    Get.toNamed(AppRouter.channelProfileEditScreen);
  }
}
