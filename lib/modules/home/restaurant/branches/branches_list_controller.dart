import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BranchesListController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var branches = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var selectedIndex = 0.obs;
  final List<String> categories = ["Recent", "Popular"];

  void changeCategory(int index) {
    selectedIndex.value = index;
  }

  void fetchBranches(String restaurantId) async {
    isLoading(true);
    hasError(false);
  branches.clear();

    try {
      DocumentSnapshot restaurantDoc =
          await _firestore.collection('restaurants').doc(restaurantId).get();

      if (restaurantDoc.exists) {
        var data = restaurantDoc.data() as Map<String, dynamic>;
        branches.assignAll(List<Map<String, dynamic>>.from(data['branches']));
      }
    } catch (e) {
      hasError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
