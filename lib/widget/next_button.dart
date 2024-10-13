import 'package:flutter/material.dart';
import 'package:smalltin/core/constants/app_images.dart';

import '../themes/color.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 30,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(AppImages.iconArrowForward),
      ),
    );
  }
}
