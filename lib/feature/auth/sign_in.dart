import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';
import 'package:smalltin/widget/app_text_field.dart';
import 'package:smalltin/widget/content_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        return AppScaffold(
          child: controller.isBusy
              ? const Loading()
              : LayoutBuilder(
                  builder: (contexts, constraints) {
                    bool isLargeScreen = constraints.isLargeScreen;

                    return SingleChildScrollView(
                      child: isLargeScreen
                          ? Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // Centered layout for smaller screens
                                  const ContentWidget(
                                    title: "Welcome to SmallTin!",
                                    subTitle:
                                        "Your gateway to knowledge and rewards! Create your account today to start your learning journey.",
                                  ),
                                  Center(
                                      child: AppTextField(
                                    controller:
                                        controller.emailEditingController,
                                    hint: "Enter your email here",
                                    onTap: () => controller.checkUSer(context),
                                  )),
                                ],
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Centered layout for smaller screens
                                const ContentWidget(
                                  title: "Welcome to SmallTin!",
                                  subTitle:
                                      "Your gateway to knowledge and rewards! Create your account today to start your learning journey.",
                                ),
                                SizedBox(height: 30.h),
                                // Adjust TextField width to 400 on large screens
                                AppTextField(
                                  controller: controller.emailEditingController,
                                  hint: "Enter your email here",
                                  onTap: () => controller.checkUSer(context),
                                ),
                              ],
                            ),
                    );
                  },
                ),
        );
      },
    );
  }
}
