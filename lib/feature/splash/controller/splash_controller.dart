import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/auth/sign_in.dart';


class SplashController extends GetxController {
  bool? isOnboarded;
  bool? isLoggedIn;

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 5), () {
      isOnboarded = GetStorage().read("isOnboard");
      final token = Get.find<AuthController>().box.read("token");
      final onBoarded = Get.find<AuthController>().box.read("onBoarded");

      if (token == null) {
        Get.offNamed(onBoarded != null ? '/sign-in' : '/onboarding');
      } else {
        Get.offNamed('/home');
      }
    });
    super.onInit();
  }
}
