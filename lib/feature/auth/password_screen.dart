import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';

import '../../widget/auth_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: GetBuilder<AuthController>(builder: (authController) {
        return authController.isBusy
            ? const Loading()
            : Column(
                children: [
                  SizedBox(height: 50.h),
                  Image.asset(getLogo(context)),
                  SizedBox(height: 50.h),
                  Text(
                    "Enter Your Password To Continue !",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Your gateway to knowledge and rewards! Create your account today to start your learning journey.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
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
                              controller: authController.passEditingController,
                              style: Theme.of(context).textTheme.bodySmall,
                              decoration: InputDecoration(
                                hintText: "Enter your Password here",
                                hintStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10.w),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          AuthButton(
                            onTap: () {
                              authController.login(context);
                            },
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        authController.forgetPassword(context);
                      },
                      child: Text(
                        "Forget Password? ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                    ),
                  )
                ],
              );
      }),
    );
  }
}
