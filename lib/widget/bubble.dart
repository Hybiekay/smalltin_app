import 'package:flutter/material.dart';
import 'package:smalltin/themes/color.dart';

Widget bubble(String text, Color color, double size, bool isSelected,
    BuildContext context) {
  return Container(
    width: size < 70
        ? 70
        : size > 140
            ? 150
            : size,
    height: size < 70
        ? 70
        : size > 140
            ? 140
            : size,
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: isSelected ? AppColor.gray : AppColor.scaffoldBg,
      shape: BoxShape.circle,
    ),
    child: Stack(
      children: [
        Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : Colors.white),
          ),
        ),
        if (isSelected)
          const Positioned(
            right: 5,
            bottom: 5,
            child: Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 20,
            ),
          ),
      ],
    ),
  );
}
