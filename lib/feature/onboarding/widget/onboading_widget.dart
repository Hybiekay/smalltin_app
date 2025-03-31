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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if the screen width is greater than 600 (example threshold for a large screen)
        bool isLargeScreen = constraints.maxWidth > 600;

        // Column layout for small screens and row layout for large screens
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal:
                isLargeScreen ? 40.w : 20.w, // More padding on larger screens
          ),
          child: isLargeScreen
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Image on the left side
                    Image.asset(
                      widget.onboardingModel.image,
                      width: 220.h,
                      height: 200.h,
                    ),
                    // Text content on the right side
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.onboardingModel.title,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            widget.onboardingModel.subTitle,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(height: 50.h),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: widget.onPressed,
                              child: Container(
                                width: 100.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Image.asset(AppImages.iconArrowForward),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(height: 60.h),
                    Image.asset(
                      widget.onboardingModel.image,
                      width: 220.h,
                      height: 200.h,
                    ),
                    SizedBox(height: 50.h),
                    Text(
                      widget.onboardingModel.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 20.h),
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
                    SizedBox(height: 40.h),
                  ],
                ),
        );
      },
    );
  }
}
