import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';
import 'package:smalltin/widget/app_text_field.dart';
import 'package:smalltin/widget/content_widget.dart';

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
            : LayoutBuilder(builder: (contexts, snapshot) {
                return snapshot.isLargeScreen
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            ContentWidget(
                                title: "Verify Your Email",
                                subTitle:
                                    "To ensure the security of your account, we've sent a one-time verification code to the Email ${controller.emailEditingController.text} you provided."),
                            AppTextField(
                              onTap: () {
                                controller.verifyEmail(context);
                              },
                              hint: "Enter six OTP Number here",
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(6)
                              ],
                              controller: controller.otpEditingController,
                              keyboardType: TextInputType.number,
                            )
                          ])
                    : Column(
                        children: [
                          ContentWidget(
                              title: "Verify Your Email",
                              subTitle:
                                  "To ensure the security of your account, we've sent a one-time verification code to the Email ${controller.emailEditingController.text} you provided."),
                          const SizedBox(
                            height: 15,
                          ),
                          AppTextField(
                            onTap: () {
                              controller.verifyEmail(context);
                            },
                            hint: "Enter six OTP Number here",
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6)
                            ],
                            controller: controller.otpEditingController,
                            keyboardType: TextInputType.number,
                          ),
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
              });
      }),
    );
  }
}
