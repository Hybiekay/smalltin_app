import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/constants/app_images.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/contact_us/screens/contact_us.dart';
import 'package:smalltin/feature/edit_profile/screen/edit_profile.dart';
import 'package:smalltin/feature/history/screen/history.dart';
import 'package:smalltin/feature/home/controller/home_controller.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';
import 'package:smalltin/widget/image_widget.dart';
import 'package:smalltin/feature/auth/choose_field/choose_fields.dart';

class DrawerScreen extends StatelessWidget {
  final HomeController homecontroller = Get.find<HomeController>();
  DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authControler) {
      return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: authControler.isBusy
            ? const Loading()
            : Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 280,
                      ),
                      SideButton(
                        icon: AppImages.dashboard,
                        title: "Edit Profile",
                        onPressed: () {
                          Get.to(() => const EditProfile());
                          homecontroller.reset();
                        },
                      ),
                      SideButton(
                        icon: AppImages.message,
                        title: "Edit Fields",
                        onPressed: () {
                          Get.to(() => const ChooseField());
                          homecontroller.reset();
                        },
                      ),
                      SideButton(
                        icon: AppImages.call,
                        title: "Contact US",
                        onPressed: () {
                          Get.to(() => const ContactUs());
                          homecontroller.reset();
                        },
                      ),
                      SideButton(
                        icon: AppImages.setting,
                        title: "History",
                        onPressed: () {
                          Get.to(() => const HistoryStat());
                          homecontroller.reset();
                        },
                      ),
                      SideButton(
                        icon: AppImages.logOut,
                        title: "Log Out",
                        onPressed: () {
                          authControler.logout();
                          homecontroller.reset();
                        },
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "V1",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}

class SideButton extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onPressed;

  const SideButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
              ),
              child: ImageWidget(
                imagePath: icon,
                color: Theme.of(context).primaryColor,
                width: 20,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
