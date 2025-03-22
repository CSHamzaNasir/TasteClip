import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';

class BranchDetailController extends GetxController {
  var selectedIndex = 0.obs;
  final List<String> categories = ["Text", "Image", "Videos"];

  void changeCategory(int index) {
    selectedIndex.value = index;
  }

  final List<String> imageUrls = [
    AppAssets.unDesserets,
    AppAssets.unDrink,
    AppAssets.unMeal,
    AppAssets.unSnack,
    AppAssets.unVeqan,
  ];

  final List<String> selectedImageUrls = [
    AppAssets.deserts,
    AppAssets.drink,
    AppAssets.meal,
    AppAssets.snack,
    AppAssets.veqan,
  ];

  RxString selectedImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    selectedImage.value = selectedImageUrls.first;
  }

  void changeSelectedImage(int index) {
    selectedImage.value = selectedImageUrls[index];
  }
}
