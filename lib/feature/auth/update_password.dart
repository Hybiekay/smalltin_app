import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';
import 'package:smalltin/widget/app_text_field.dart';
import 'package:smalltin/widget/content_widget.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  bool isObucure = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return AppScaffold(
        child: LayoutBuilder(builder: (context, snapshot) {
          return snapshot.isLargeScreen
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ContentWidget(
                        title: "Enter Your New Password!",
                        subTitle:
                            "Your gateway to knowledge and rewards! Create your account today to start your learning journey."),
                    AppTextField(
                      onTap: () {
                        authController.updatePassword(context);
                      },
                      hint: "Enter Your Password here",
                      controller: authController.passwordEditingController,
                    )
                  ],
                )
              : Column(
                  children: [
                    const ContentWidget(
                        title: "Enter Your New Password!",
                        subTitle:
                            "Your gateway to knowledge and rewards! Create your account today to start your learning journey."),
                    const SizedBox(height: 20),
                    AppTextField(
                      onTap: () {
                        authController.updatePassword(context);
                      },
                      hint: "Enter Your Password here",
                      controller: authController.passwordEditingController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                );
        }),
      );
    });
  }
}

class ComfirmPassword extends StatefulWidget {
  const ComfirmPassword({super.key});

  @override
  State<ComfirmPassword> createState() => _ComfirmPasswordState();
}

class _ComfirmPasswordState extends State<ComfirmPassword> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: GetBuilder<AuthController>(builder: (authController) {
        return authController.isBusy
            ? const Loading()
            : LayoutBuilder(builder: (contexts, snapshot) {
                return snapshot.isLargeScreen
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const ContentWidget(
                            title: "Comfirm Your New Password To Continue !",
                            subTitle:
                                "Are you sure you input correct password?, please confirm your password by entering it again below. By adding Your Confriming your new password you will be log in automaticaly",
                          ),
                          AppTextField(
                              onTap: () {
                                authController.updatePassword(context);
                              },
                              hint: "Enter Your Password here",
                              controller: authController
                                  .confrimPasswordEditingController)
                        ],
                      )
                    : Column(
                        children: [
                          const ContentWidget(
                            title: "Comfirm Your New Password To Continue !",
                            subTitle:
                                "Are you sure you input correct password?, please confirm your password by entering it again below. By adding Your Confriming your new password you will be log in automaticaly",
                          ),
                          AppTextField(
                            onTap: () {
                              authController.updateMainPassword(context);
                            },
                            hint: "Enter Your Password here",
                            controller:
                                authController.confrimPasswordEditingController,
                          ),
                        ],
                      );
              });
      }),
    );
  }
}
