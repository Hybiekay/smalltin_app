import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import '../widget/app_scaffold.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return AppScaffold(
      child: Image.asset(getLogo(context)),
    );
  }
}
