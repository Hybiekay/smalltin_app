// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smalltin/apis/auth.dart';
import 'package:smalltin/core/constants/dialog.dart';
import 'package:smalltin/feature/auth/password_screen.dart';
import 'package:smalltin/feature/auth/sign_in.dart';
import 'package:smalltin/feature/auth/update_username.dart';
import 'package:smalltin/feature/auth/verify_email.dart';
import 'package:smalltin/feature/home/home.dart';
import '../choose_field/choose_fields.dart';
import '../choose_field/choose_sub_field.dart';
import '../update_password.dart';

class AuthController extends GetxController {
  final box = GetStorage();
  bool isBusy = false;
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController otpEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController confrimPasswordEditingController =
      TextEditingController();

  final AuthService _authService = AuthService();


@override
  void onClose() {
   emailEditingController.dispose();
   otpEditingController.dispose();
   passwordEditingController.dispose();
   passEditingController.dispose();
   nameEditingController.dispose();
   confrimPasswordEditingController.dispose();
    super.onClose();
  }


  checkUSer(BuildContext context) async {
    if (emailEditingController.text.isEmail) {
      isBusy = true;
      update();
      var res = await _authService.login(emailEditingController.text);
      isBusy = false;
      update();
      if (res != null) {
        var data = jsonDecode(res.body);
        if (res.statusCode == 200) {
          Get.to(() => const PasswordScreen());
        } else if (res.statusCode == 201) {
          Get.to(() => const VerifyEmail());
        } else if (res.statusCode == 202) {
          AppDailog.error(
              context: context,
              title: data["message"],
              message:
                  "Your Email is not Verified by pressing Ok we will send one time password to your email",
              onPressed: () {
                Get.back();
                resendOtp();
              });
        } else if (res.statusCode == 203 &&
            data["message"] == "Username is not set.") {
          AppDailog.error(
              context: context,
              title: data["message"],
              buttonText: "Let's go",
              message: data["error"] ?? "Your Registration is not Complete",
              onPressed: () {
                Get.to(() => const PasswordScreen());
              });
        } else {
          AppDailog.error(
              context: context,
              title: data["message"],
              message: data["error"] ?? "Your Registration is not Complete",
              onPressed: () {
                Get.back();
              });
        }
      }
    } else {}
  }

  login(BuildContext context) async {
    if (emailEditingController.text.isEmail) {
      isBusy = true;
      update();
      var res = await _authService.loginWithPassword(
          emailEditingController.text, passEditingController.text);
      isBusy = false;

      update();

      if (res != null) {
        var data = jsonDecode(res.body);
        box.write('token', data["token"]);
        if (res.statusCode == 200) {
          Get.to(() => const HomeScreen());
        } else if (res.statusCode == 203 &&
            data["message"] == "Username is not set.") {
          Get.to(() => const UpdateName());
        } else {
          AppDailog.error(
              context: context,
              title: data["message"],
              message: data["error"] ??
                  "The password you entered does not match the one you registered with. Please try to recover your password.",
              onPressed: () {
                Get.back();
              });
        }
      }
    } else {}
  }

  resendOtp() async {
    isBusy = true;
    update();
    var res = await _authService.resendOtp(emailEditingController.text);
    isBusy = false;
    update();
    if (res != null) {
      if (res.statusCode == 200) {
        Get.to(() => const VerifyEmail());
      }
    }
  }

  verifyEmail(BuildContext context) async {
    if (otpEditingController.text.length < 6) {
      AppDailog.error(
          onPressed: () {
            Get.back();
          },
          context: context,
          buttonText: "Back",
          message: "OTP Is less Then the required lenght");
    } else {
      isBusy = true;
      update();
      var res = await _authService.verifyOtp(
          emailEditingController.text, otpEditingController.text);
      isBusy = false;
      update();
      if (res != null) {
        var data = jsonDecode(res.body);
        if (res.statusCode == 200) {
          box.write('token', data["token"]);
          Get.to(() => const CreatePassword());
        } else {
          AppDailog.error(
              onPressed: () {
                Get.back();
              },
              context: context,
              buttonText: "Back",
              message: data["message"]);
        }
      }
    }
  }

  updatePassword(BuildContext context) async {
    if (passwordEditingController.text.length < 6) {
      AppDailog.error(
          onPressed: () {
            Get.back();
          },
          context: context,
          buttonText: "Back",
          message: "Password Is less Then the required lenght");
    } else if (passwordEditingController.text.length >= 6) {
      Get.off(() => const ComfirmPassword());
    }
  }

  updateMainPassword(BuildContext context) async {
    var token = box.read("token");
    if (passwordEditingController.text !=
        confrimPasswordEditingController.text) {
      AppDailog.error(
          onPressed: () {
            Get.to(() => const CreatePassword());
          },
          context: context,
          buttonText: "Back",
          message:
              "The password is not confimed check and correct you password");
    } else {
      isBusy = true;
      update();
      var res = await _authService.updatePassword(
          passwordEditingController.text,
          confrimPasswordEditingController.text,
          token);
      isBusy = false;
      update();
      if (res != null) {
        jsonDecode(res.body);
        if (res.statusCode == 200) {
          var data = jsonDecode(res.body);
          if (res.statusCode == 200) {
            if (data["user"]["username"] == null) {
              AppDailog.error(
                  title: data["message"],
                  onPressed: () {
                    Get.off(() => const UpdateName());
                  },
                  context: context,
                  buttonText: "Let's go",
                  message: "It time to shows your you unique identity");
            } else if (data["user"]["fields"] == null) {
              AppDailog.error(
                  title: data["message"],
                  onPressed: () {
                    Get.off(() => const ChooseField());
                  },
                  context: context,
                  buttonText: "Let's go",
                  message: "You haven't selected any fields yet.");
            } else if (data["user"]["sub_fields"] == null) {
              AppDailog.error(
                  onPressed: () {
                    Get.off(() => ChooseSubField(
                          mainField: data["user"]["fields"],
                        ));
                  },
                  context: context,
                  buttonText: "Let's go",
                  message: "You haven't selected any subfields yet.");
            } else {
              AppDailog.error(
                  onPressed: () {
                    login(context);
                  },
                  context: context,
                  buttonText: "Log me in",
                  title: data["message"],
                  message: "You haven't selected any subfields yet.");
            }
          } else {
            AppDailog.error(
                onPressed: () {
                  Get.back();
                },
                context: context,
                buttonText: "Back",
                message: data["message"]);
          }
        }
      }
    }
  }

  updateName(BuildContext context) async {
    var token = box.read("token");

    isBusy = true;
    update();
    var res =
        await _authService.updateName(nameEditingController.text.trim(), token);
    isBusy = false;
    update();
    if (res != null) {
      var data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return "Your username is available.";
      } else {
        return "Opos! ${data["message"]}";
      }
    }
  }

  updateBio(BuildContext context, String bio) async {
    var token = box.read("token");

    var res = await _authService.updateBio(bio.trim(), token);

    if (res != null) {
      var data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return "Your username is available.";
      } else {
        return "Opos! ${data["message"]}";
      }
    }
  }

  updateFields({
    required BuildContext context,
    required List<int> field,
  }) async {
    var token = box.read("token");
    isBusy = true;
    update();
    var res = await _authService.updateFields(field, token);
    isBusy = false;
    update();
    if (res != null) {
      var data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        AppDailog.error(
            title: data["message"],
            onPressed: () {
              Get.off(() => ChooseSubField(
                    mainField: field,
                  ));
            },
            context: context,
            buttonText: "Let's go",
            message: "Your account is all Set.");
      }
    }
  }

  updateSubFields(
      {required BuildContext context, required List<int> subFields}) async {
    var token = box.read("token");
    isBusy = true;
    update();
    var res = await _authService.updateSubFields(subFields, token);
    isBusy = false;
    update();
    if (res != null) {
      var data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        AppDailog.error(
            title: data["message"],
            onPressed: () {
              Get.offAll(() => const HomeScreen());
            },
            context: context,
            buttonText: "Let's go",
            message: "Your account is all Set.");
      }
    }
  }

  forgetPassword(BuildContext context) {
    AppDailog.error(
        context: context,
        onPressed: () async {
          Get.back();
          isBusy = true;
          update();
          var res =
              await _authService.forgetPassword(emailEditingController.text);

          isBusy = false;
          update();
          if (res != null && res.statusCode == 200) {
            var data = json.decode(res.body);
            if (data["message"] == "Verification Otp sent Succesfully ") {}
            Get.to(() => const VerifyEmail());
          }
        },
        buttonText: "Continue",
        title: "Notice",
        message:
            "By continuing, we will send a verification email to ${emailEditingController.text}.");
  }

  getUser() async {
    var token = box.read("token");
    isBusy = true;
    update();
    var res = await _authService.getuser(token);
    isBusy = false;
    update();
    return res;
  }

  logout() async {
    var token = box.read("token");
    isBusy = true;
    update();
    await _authService.logout(token);
    box.remove("token");
    isBusy = false;
    update();

    Get.offAll(() => const SignInScreen());
  }

  uploadImage(File image) {
    var token = box.read("token");
    _authService.uploadProfileImage(image, token);
  }
}
