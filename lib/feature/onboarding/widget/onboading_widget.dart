import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smalltin/core/constants/app_images.dart';

import '../models/onboarding_model.dart';

class OnBoardingWidget extends StatefulWidget {
  final OnboardingModel onboardingModel;
  final VoidCallback onPressed;
  const OnBoardingWidget({
    super.key,
    required this.onboardingModel,
    required this.onPressed,
  });

  @override
  State<OnBoardingWidget> createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends State<OnBoardingWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 60.h,
          ),
          Image.asset(
            widget.onboardingModel.image,
            width: 220.h,
            height: 200.h,
          ),
          SizedBox(
            height: 50.h,
          ),
          Text(
            widget.onboardingModel.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            widget.onboardingModel.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: widget.onPressed,
              child: Container(
                width: 110.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(AppImages.iconArrowForward),
              ),
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
        ],
      ),
    );
  }
}
