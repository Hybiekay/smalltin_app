import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smalltin/feature/auth/sign_in.dart';

import 'package:smalltin/feature/home/home.dart';
import 'package:smalltin/feature/onboarding/screens/onboarding_screen.dart';

class SplashController extends GetxController {
  bool? isOnboarded;
  bool? isLoggedIn;

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 5), () {
      isOnboarded = GetStorage().read("isOnboard");

      if (isOnboarded == true && isLoggedIn == null) {
        Get.to(() => const SignInScreen());
      } else if (isOnboarded == true && isLoggedIn == false) {
        Get.to(() => const SignInScreen());
      } else if (isOnboarded == true && isLoggedIn == true) {
        Get.to(() => const HomeScreen());
      } else {
        Get.to(() => const OnboardingScreen());
      }
    });
    super.onInit();
  }
}
