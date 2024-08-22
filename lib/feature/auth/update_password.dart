import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';

import '../../widget/auth_button.dart';

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
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Image.asset(getLogo(context)),
            SizedBox(height: 50.h),
            Text(
              "Enter Your New Password!",
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
                child: PasswordTextField(
                  controller: authController.passwordEditingController,
                  onTap: () {
                    authController.updatePassword(context);
                  },
                )),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    });
  }
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key, this.controller, required this.onTap});
  final TextEditingController? controller;

  final VoidCallback onTap;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isObucure = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            obscureText: isObucure,
            controller: widget.controller,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
                hintText: "Enter Your Password here",
                hintStyle: Theme.of(context).textTheme.bodySmall,
                contentPadding: EdgeInsets.all(10.w),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObucure = !isObucure;
                      });
                    },
                    child: Icon(
                        isObucure ? Icons.visibility : Icons.visibility_off))),
          ),
        ),
        AuthButton(onTap: widget.onTap),
      ],
    );
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
            : Column(
                children: [
                  SizedBox(height: 50.h),
                  Image.asset(getLogo(context)),
                  SizedBox(height: 50.h),
                  Text(
                    "Comfirm Your New Password To Continue !",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Are you sure you input correct password?, please confirm your password by entering it again below. By adding Your Confriming your new password you will be log in automaticaly",
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
                      child: PasswordTextField(
                        controller: authController.confrimPasswordEditingController,
                        onTap: () {
                          authController.updateMainPassword(context);
                        },
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              );
      }),
    );
  }
}
