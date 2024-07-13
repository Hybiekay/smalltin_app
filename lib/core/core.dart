import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/constants/app_images.dart';

String getLogo(BuildContext context) {
  return context.isDarkMode ? AppImages.darkModeLogo : AppImages.logoPath;
}

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor"; // Add the alpha value if not present
  }
  return Color(int.parse(hexColor, radix: 16));
}
