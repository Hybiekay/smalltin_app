import 'package:flutter/material.dart';
import 'package:smalltin/themes/color.dart';

class QuizButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const QuizButton({super.key, required this.onTap, this.text = 'Re- Attemt'});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColor.gray,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 35,
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColor.scaffoldBg,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
