import 'package:get/get.dart';

class HomeController extends GetxController {
  var xOffSet = 0.0.obs; // Observable double
  var yOffSet = 0.0.obs; // Observable double
  var isDrawerOpen = false.obs; // Observable boolean

  void openCloseDrawer() {
    if (isDrawerOpen.value) {
      xOffSet.value = 0;
      yOffSet.value = 0;
      isDrawerOpen.value = false;
    } else {
      xOffSet.value = 290;
      yOffSet.value = 80;
      isDrawerOpen.value = true;
    }
  }

  void reset() {
    xOffSet.value = 0;
    yOffSet.value = 0;
    isDrawerOpen.value = false;
  }

  @override
  void onClose() {
    reset();
    super.onClose();
  }

  @override
  void onInit() {
    reset();
    super.onInit();
  }
}
