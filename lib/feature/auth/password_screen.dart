import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';
import 'package:smalltin/widget/app_text_field.dart';
import 'package:smalltin/widget/content_widget.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool isObcure = true;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: LayoutBuilder(builder: (contexts, snapshot) {
        return GetBuilder<AuthController>(builder: (authController) {
          return authController.isBusy
              ? const Loading()
              : snapshot.isLargeScreen
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const ContentWidget(
                            title: "Enter Your Password To Continue !",
                            subTitle:
                                "Your gateway to knowledge and rewards! Create your account today to start your learning journey.",
                          ),
                          AppTextField(
                            onTap: () {
                              authController.login(context);
                            },
                            hint: "Enter Your Password here",
                            controller: authController.passEditingController,
                            isPassword: true,
                          )
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(height: 50.h),
                        const ContentWidget(
                          title: "Enter Your Password To Continue !",
                          subTitle:
                              "Your gateway to knowledge and rewards! Create your account today to start your learning journey.",
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        AppTextField(
                          onTap: () {
                            authController.login(context);
                          },
                          hint: "Enter Your Password here",
                          controller: authController.passEditingController,
                          isPassword: true,
                        ),
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
        });
      }),
    );
  }
}
