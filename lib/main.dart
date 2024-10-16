import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/feature/auth/choose_field/controller/field_controller.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/themes/controller/theme_control.dart';
import 'package:smalltin/themes/themes.dart';
import 'package:get_storage/get_storage.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(ThemesController());
  // Initialize only if not on the web
  // if (!kIsWeb) {
  //   MobileAds.instance.initialize();
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(FieldsController());
    Get.put(AuthController());
    return ScreenUtilInit(builder: (context, _) {
      return GetBuilder<ThemesController>(builder: (controller) {
        return GetMaterialApp(
          title: 'SmallTin',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          debugShowCheckedModeBanner: false,
          themeMode: Get.find<ThemesController>().themeData(),
          initialRoute: '/splash',
          getPages: AppRoutes.routes,
          // onInit: () {
          //   final token = Get.find<AuthController>().box.read("token");
          //   final onBoarded =
          //       Get.find<AuthController>().box.read("onBoarded");

          //   if (token == null) {
          //     Get.offNamed(onBoarded != null ? '/sign-in' : '/onboarding');
          //   } else {
          //     Get.offNamed('/home');
          //   }
          // }
        );
      });
    });
  }
}
