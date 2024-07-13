import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/constants/app_images.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';

class UpdateName extends StatefulWidget {
  const UpdateName({super.key});

  @override
  State<UpdateName> createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: GetBuilder<AuhtController>(builder: (auhtController) {
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
                        controller: auhtController.nameEditingController,
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
                    GestureDetector(
                      onTap: () {
                        auhtController.updateName(context);
                      },
                      child: Container(
                        width: 80.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(AppImages.iconArrowForward),
                      ),
                    ),
                  ],
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
