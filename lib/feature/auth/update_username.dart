import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/choose_field/choose_fields.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/widget/auth_button.dart';

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
        return Column(
          children: [
            SizedBox(height: 50.h),
            Image.asset(getLogo(context)),
            SizedBox(height: 50.h),
            Text(
              "Choose Your Username",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 20.h),
            Text(
              "Enter a username that represents you on SmallTin. This will be visible to other users in the community.",
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
                        onChanged: (v) async {
                          var value = await authController.updateName(context);
                          if (v.length < 3) {
                            setState(() {
                              correct = false;
                              values = "Name Is less Then the required lenght";
                            });
                          } else if (value == 'Your username is available.') {
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
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                          hintText: "Enter your username here",
                          hintStyle: Theme.of(context).textTheme.bodySmall,
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
                        if (correct) {
                          Get.to(() => const ChooseField());
                        } else {
                          Get.snackbar("Change Your username",
                              "Try to use a unique username, because the on you choose has already been use",
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                    ),
                  ],
                )),
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
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.start,
                              )
                            : Text(
                               values ==''? '':  "$values ❌",
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
      }),
    );
  }
}
