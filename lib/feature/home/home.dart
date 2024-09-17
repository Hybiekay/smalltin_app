import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/controller/user_controller.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/home/controller/home_controller.dart';
import 'package:smalltin/feature/home/widget/drawer.dart';
import 'package:smalltin/feature/home/widget/front_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.put(AuthController());
  final UserController userController = Get.put(UserController());
  final HomeController homecontroller = Get.put(HomeController());

  @override
  void dispose() {
    homecontroller.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              DrawerScreen(),
              const FrontPage(),
            ],
          ),
        ),
      ),
    );
  }
}
