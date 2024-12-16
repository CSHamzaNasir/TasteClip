import 'package:get/get.dart';

import '../../utils/app_string.dart';

class ChannelHomeController extends GetxController {
  int selectedIndex = 0;
  final List<String> labels = [AppString.videos, "Text", "Images"];

  void updateIndex(int index) {
    selectedIndex = index;
    update();
  }
}
