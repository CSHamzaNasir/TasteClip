import 'package:get/get.dart';

class BranchDetailController extends GetxController {
  var selectedIndex = 0.obs;

  final List<String> categories = ["Text", "Image", "Videos"];

  void changeCategory(int index) {
    selectedIndex.value = index;
  }
}
