import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';

import '../../widget/auth_button.dart';

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
                  builder: (context, constraints) {
                    bool isLargeScreen = constraints.maxWidth > 600;

                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.r,
                          vertical: 20.h,
                        ),
                        child: isLargeScreen
                            ? Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    LogoWecomeMsg(isLargeScreen: isLargeScreen),
                                    Center(
                                        child: AppTextField(
                                            isLargeScreen: isLargeScreen)),
                                  ],
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 50.h),

                                  // Centered layout for smaller screens
                                  LogoWecomeMsg(
                                    isLargeScreen: isLargeScreen,
                                  ),
                                  SizedBox(height: 30.h),
                                  // Adjust TextField width to 400 on large screens
                                  AppTextField(isLargeScreen: isLargeScreen),
                                  const SizedBox(height: 15),
                                ],
                              ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.isLargeScreen,
  });

  final bool isLargeScreen;

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    return Container(
      width: isLargeScreen
          ? MediaQuery.sizeOf(context).width * 0.4
          : double.infinity,
      height: 40.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.emailEditingController,
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                hintText: "Enter your email here",
                hintStyle: Theme.of(context).textTheme.bodySmall,
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          AuthButton(onTap: () {
            controller.checkUSer(context);
          }),
        ],
      ),
    );
  }
}

class LogoWecomeMsg extends StatelessWidget {
  const LogoWecomeMsg({
    super.key,
    required this.isLargeScreen,
  });

  final bool isLargeScreen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isLargeScreen ? MediaQuery.sizeOf(context).width * 0.4 : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            getLogo(context),
            height: 150.h,
          ),
          Text(
            "Welcome to SmallTin!",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 20.h),
          Text(
            "Your gateway to knowledge and rewards! Create your account today to start your learning journey.",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
