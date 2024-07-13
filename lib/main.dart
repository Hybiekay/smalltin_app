import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/feature/auth/choose_field/controller/field_controller.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/auth/sign_in.dart';
import 'package:smalltin/feature/home/home.dart';
import 'package:smalltin/feature/onboarding/screens/onboarding_screen.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';
import 'package:smalltin/themes/controller/theme_control.dart';
import 'package:smalltin/themes/themes.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  Get.put(ThemesController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(FieldsController());
    Get.put(AuhtController());
    return GetBuilder<ThemesController>(builder: (controller) {
      return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return GetMaterialApp(
                title: 'SmallTin',
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                debugShowCheckedModeBanner: false,
                themeMode: Get.find<ThemesController>().themeData(),
                home: GetBuilder<AuhtController>(
                  builder: (auhtController) {
                    if (auhtController.box.read("token") == null) {
                      if (auhtController.box.read("onBoarded") != null) {
                        return const SignInScreen();
                      } else {
                        return const OnboardingScreen();
                      }
                    } else if (auhtController.box.read("token") != null) {
                      return const HomeScreen();
                    } else {
                      return const LoadingScreen();
                    }
                  },
                ));
          });
    });
  }
}
