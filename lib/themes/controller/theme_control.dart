import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemesController extends GetxController {
  late bool? isLight;

  @override
  void onInit() {
    super.onInit();
    isLight = GetStorage().read('isLight');
  }

  ThemeMode themeData() {
    if (isLight == null) {
      return ThemeMode.system;
    } else if (isLight!) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  void setTheme(bool isLightTheme) {
    isLight = isLightTheme;
    GetStorage().write('isLight', isLight);
    update();
  }
}
