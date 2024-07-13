import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/constants/app_images.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuhtController>(
        init: AuhtController(),
        builder: (controller) {
          return AppScaffold(
              child: controller.isBusy
                  ? const Loading()
                  : Column(
                      children: [
                        SizedBox(height: 50.h),
                        Image.asset(getLogo(context)),
                        SizedBox(height: 50.h),
                        Text(
                          "Welcome to SmallTin!",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Your gateway to knowledge and rewards! Create your account today to start your learning journey.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller:
                                        controller.emailEditingController,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    decoration: InputDecoration(
                                      hintText: "Enter your email here",
                                      hintStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.checkUSer(context);
                                  },
                                  child: Container(
                                    width: 80.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child:
                                        Image.asset(AppImages.iconArrowForward),
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ));
        });
  }
}
