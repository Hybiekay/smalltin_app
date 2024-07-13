import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smalltin/core/constants/app_images.dart';
import 'package:smalltin/feature/auth/sign_in.dart';
import 'package:smalltin/feature/onboarding/models/onboarding_model.dart';

class OnboardingController extends GetxController {
  final box = GetStorage();
  Timer? timer;
  final PageController pageController = PageController();

  @override
  void onInit() {
    animate();
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    pageController.dispose();
    super.onClose();
  }

  void handlePress() {
    if (pageController.page == 3) {
      box.write("onBoarded", true);
      Get.to(() => const SignInScreen());
    } else {
      pageController.nextPage(
        duration: const Duration(microseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }

  animate() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (pageController.page == 3) {
        pageController.animateTo(
          0,
          duration: const Duration(microseconds: 200),
          curve: Curves.easeIn,
        );
      } else {
        pageController.nextPage(
          duration: const Duration(microseconds: 200),
          curve: Curves.easeIn,
        );
      }
    });
  }

  List<OnboardingModel> modes = [
    OnboardingModel(
        title: "Welcome to SmallTin!",
        subTitle:
            "Get ready to expand your knowledge and earn Job\$ along the way! Let's get started with a quick tour to help you navigate the app effortlessly.",
        image: AppImages.onboarding1),
    OnboardingModel(
        title: "Answer Questions & Earn Job\$",
        subTitle:
            "Ready to put your knowledge to the test? Answer questions based on your selected fields and earn 50 Job\$ for each correct answer.",
        image: AppImages.onboarding2),
    OnboardingModel(
        title: "Track Your Progress",
        subTitle:
            "Keep tabs on your progress and see how you're improving over time. Check your total Job\$ earned and view your rank on the leaderboard",
        image: AppImages.onboarding3),
    OnboardingModel(
        title: "Convert Job\$ to Money",
        subTitle:
            "At the end of each month, the user with the highest Job\$ will have the opportunity to convert their Job\$ into real money! It's a chance to turn your dedication and knowledge into tangible rewards",
        image: AppImages.onboarding4),
  ];
}
