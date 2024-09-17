import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/themes/color.dart';

import '../../auth/controller/auth_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController textEditingController = TextEditingController();
  String values = '';
  bool correct = false;

  File? image;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbarTitle: const Text(
        "Edit Profile",
        style: TextStyle(
          color: AppColor.gray,
          fontSize: 18,
        ),
      ),
      child: SingleChildScrollView(
        child: GetBuilder<AuthController>(builder: (authController) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: image != null ? FileImage(image!) : null,
                    ),
                    Positioned(
                      bottom: 14,
                      right: 12,
                      child: GestureDetector(
                        onTap: () async {
                          var file = await pickProfileImage(ImageSource.camera);
                          setState(() {
                            image = file;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.scaffoldBg),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: authController.nameEditingController,
                  onChanged: (v) async {
                    var value = await authController.updateName(
                      context,
                    );
                    debugPrint(value.runtimeType.toString());
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
                  keyboardType: TextInputType.name,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    hintText: "Enter Your New UserName",
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    border: outlineInputBorder(context),
                    enabledBorder: outlineInputBorder(context),
                    focusedBorder: outlineInputBorder(context),
                  ),
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
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
                      ),
                const SizedBox(height: 20),
                TextField(
                  controller: textEditingController,
                  minLines: 4,
                  maxLines: 5,
                  onChanged: (v) async {
                    await authController.updateBio(context, v);
                  },
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    hintText: "Enter Your New Bio",
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10),
                    border: outlineInputBorder(context),
                    enabledBorder: outlineInputBorder(context),
                    focusedBorder: outlineInputBorder(context),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (image != null) {
                      authController.uploadImage(image!);
                    }
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: AppColor.scaffoldBg,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        "Update Profile",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColor.gray),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50)
              ],
            ),
          );
        }),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
        borderSide: context.isDarkMode
            ? const BorderSide(color: AppColor.gray)
            : const BorderSide());
  }
}
