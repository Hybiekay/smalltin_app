import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/choose_field/choose_fields.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/widget/app_text_field.dart';
import 'package:smalltin/widget/content_widget.dart';

class UpdateName extends StatefulWidget {
  const UpdateName({super.key});

  @override
  State<UpdateName> createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
  String values = '';
  bool correct = false;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: GetBuilder<AuthController>(builder: (authController) {
        return LayoutBuilder(builder: (contexts, snapshot) {
          return snapshot.isLargeScreen
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ContentWidget(
                      title: "Choose Your Username",
                      subTitle:
                          "Enter a username that represents you on SmallTin. This will be visible to other users in the community.",
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextField(
                            onTap: () {
                              if (correct) {
                                Get.to(() => const ChooseField());
                              } else {
                                Get.snackbar("Change Your username",
                                    "Try to use a unique username, because the on you choose has already been use",
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            },
                            hint: "Enter your username here",
                            onChanged: (v) async {
                              if (v.length < 3) {
                                setState(() {
                                  correct = false;
                                  values =
                                      "Name Is less Then the required lenght";
                                });
                                return;
                              }
                              var value =
                                  await authController.updateName(context);
                              if (value == 'Your username is available.') {
                                setState(() {
                                  correct = true;
                                  values = "Your username is available.";
                                });
                              } else {
                                setState(() {
                                  correct = false;
                                  values = value;
                                });
                              }
                            },
                            controller: authController.nameEditingController,
                          ),
                          authController.isBusy
                              ? const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  child: correct
                                      ? Text(
                                          "$values ✅😍",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          textAlign: TextAlign.start,
                                        )
                                      : Text(
                                          values == '' ? '' : "$values ❌",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.red),
                                          textAlign: TextAlign.start,
                                        ),
                                )
                        ],
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    const ContentWidget(
                      title: "Choose Your Username",
                      subTitle:
                          "Enter a username that represents you on SmallTin. This will be visible to other users in the community.",
                    ),
                    AppTextField(
                      onTap: () {
                        if (correct) {
                          Get.to(() => const ChooseField());
                        } else {
                          Get.snackbar("Change Your username",
                              "Try to use a unique username, because the on you choose has already been use",
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                      hint: "Enter your username here",
                      onChanged: (v) async {
                        if (v.length < 3) {
                          setState(() {
                            correct = false;
                            values = "Name Is less Then the required lenght";
                          });
                          return;
                        }
                        var value = await authController.updateName(context);
                        if (value == 'Your username is available.') {
                          setState(() {
                            correct = true;
                            values = "Your username is available.";
                          });
                        } else {
                          setState(() {
                            correct = false;
                            values = value;
                          });
                        }
                      },
                      controller: authController.nameEditingController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    authController.isBusy
                        ? const Align(
                            alignment: Alignment.bottomLeft,
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                correct
                                    ? Text(
                                        "$values ✅😍",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        textAlign: TextAlign.start,
                                      )
                                    : Text(
                                        values == '' ? '' : "$values ❌",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.red),
                                        textAlign: TextAlign.start,
                                      ),
                              ],
                            ),
                          )
                  ],
                );
        });
      }),
    );
  }
}
