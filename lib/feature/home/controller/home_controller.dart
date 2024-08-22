import 'package:get/get.dart';

class HomeController extends GetxController {
  double xOffSet = 0;
  double yOffSet = 0;
  bool isDrawerOpen = false;

  void openCloseDrawer() {
    if (isDrawerOpen) {
      xOffSet = 0;
      yOffSet = 0;
      isDrawerOpen = false;
      update();
    } else {
      xOffSet = 290;
      yOffSet = 80;
      isDrawerOpen = true;
      update();
    }
  }

  reset() {
    xOffSet = 0;
    yOffSet = 0;
    isDrawerOpen = false;
    update();
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
