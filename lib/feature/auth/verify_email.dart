import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';
import 'package:smalltin/widget/auth_button.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: GetBuilder<AuthController>(builder: (controller) {
        return controller.isBusy
            ? const Loading()
            : Column(
                children: [
                  SizedBox(height: 50.h),
                  Image.asset(getLogo(context)),
                  SizedBox(height: 50.h),
                  Text(
                    "Verify Your Email",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "To ensure the security of your account, we've sent a one-time verification code to the Email ${controller.emailEditingController.text} you provided.",
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
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(6)
                              ],
                              controller: controller.otpEditingController,
                              keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.bodySmall,
                              decoration: InputDecoration(
                                hintText: "Enter six OTP Number here",
                                hintStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          AuthButton(
                            onTap: () {
                              controller.verifyEmail(context);
                            },
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: GestureDetector(
                  //     onTap: () {},
                  //     child: Text(
                  //       "Forget Password? ",
                  //     ),
                  //   ),
                  // )
                ],
              );
      }),
    );
  }
}
