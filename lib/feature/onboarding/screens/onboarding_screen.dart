import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smalltin/feature/onboarding/controller/onboard_controller.dart';
import 'package:smalltin/feature/onboarding/widget/onboading_widget.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  OnboardingController onboardingController = Get.put(OnboardingController());
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: GetBuilder<OnboardingController>(builder: (controll) {
        return PageView(
          controller: controll.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: controll.modes
              .map(
                (onboardingModel) => OnBoardingWidget(
                  onboardingModel: onboardingModel,
                  onPressed: controll.handlePress,
                ),
              )
              .toList(),
        );
      }),
    );
  }
}
