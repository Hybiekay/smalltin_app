import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/controller/theme_control.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemesController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          if (controller.isLight == null) {
            if (context.isDarkMode) {
              Get.find<ThemesController>().setTheme(true);
            } else {
              Get.find<ThemesController>().setTheme(false);
            }
          } else {
            Get.find<ThemesController>().setTheme(!controller.isLight!);
          }
        },
        child: Icon(
          controller.isLight == null
              ? context.isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode
              : controller.isLight == true
                  ? Icons.light_mode
                  : Icons.dark_mode,
        ),
      ),
    );
  }
}
