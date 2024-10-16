// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smalltin/apis/auth.dart';
import 'package:smalltin/core/constants/dialog.dart';
import 'package:smalltin/core/core.dart';

class AuthController extends GetxController {
  final box = GetStorage();
  String tokenKey = "5f67d9a2c8e3f6b1d4e7g8h2i3j4k5l6";
  String userKey = "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6";

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
          Get.toNamed(
            '/auth/login',
          );
        } else if (res.statusCode == 201) {
          Get.toNamed(
            '/auth/verify-email',
          );
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
                Get.toNamed(
                  '/auth/login',
                );
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

        String enc = encryptData(data["token"].toString(), tokenKey);

        box.write('token', enc);
        if (res.statusCode == 200) {
          Get.offAllNamed(
            '/',
          );
        } else if (res.statusCode == 203 &&
            data["message"] == "Username is not set.") {
          Get.offNamed(
            '/auth/update-username',
          );
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
        Get.toNamed(
          '/auth/verify-email',
        );
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
          box.write('token', encryptData(data["token"].toString(), tokenKey));
          Get.toNamed(
            '/auth/create-password',
          );
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
      Get.offNamed(
        "/auth/confirm-password",
      );
    }
  }

  updateMainPassword(BuildContext context) async {
    var token = decryptData(box.read("token"), tokenKey);
    if (passwordEditingController.text !=
        confrimPasswordEditingController.text) {
      AppDailog.error(
          onPressed: () {
            Get.toNamed(
              '/auth/create-password',
            );
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
                    Get.offNamed(
                      "auth/update-username",
                    );
                  },
                  context: context,
                  buttonText: "Let's go",
                  message: "It time to shows your you unique identity");
            } else if (data["user"]["fields"] == null) {
              AppDailog.error(
                  title: data["message"],
                  onPressed: () {
                    Get.offNamed(
                      "/choose-fields",
                    );
                  },
                  context: context,
                  buttonText: "Let's go",
                  message: "You haven't selected any fields yet.");
            } else if (data["user"]["sub_fields"] == null) {
              AppDailog.error(
                  onPressed: () {
                    Get.offNamed('/choose-sub-fields',
                        arguments: data["user"]
                            ["fields"]); // Pass the list directly
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
    var token = decryptData(box.read("token"), tokenKey);

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
    var token = decryptData(box.read("token"), tokenKey);

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
    var token = decryptData(box.read("token"), tokenKey);
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
              Get.offNamed('/choose-sub-fields',
                  arguments: field); // Pass the list directly
            },
            context: context,
            buttonText: "Let's go",
            message: "Your account is all Set.");
      }
    }
  }

  updateSubFields(
      {required BuildContext context, required List<int> subFields}) async {
    var token = decryptData(box.read("token"), tokenKey);
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
              Get.offAllNamed(
                "/",
              );
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
            Get.toNamed(
              '/auth/verify-email',
            );
          }
        },
        buttonText: "Continue",
        title: "Notice",
        message:
            "By continuing, we will send a verification email to ${emailEditingController.text}.");
  }

  getUser() async {
    var token = decryptData(box.read("token"), tokenKey);

    isBusy = true;
    update();
    var res = await _authService.getuser(token);
    isBusy = false;
    update();
    return res;
  }

  logout() async {
    var token = decryptData(box.read("token"), tokenKey);

    isBusy = true;
    update();
    await _authService.logout(token);
    box.remove("token");
    isBusy = false;
    update();

    Get.offAllNamed(
      "/auth/sign-in",
    );
  }

  uploadImage(File image) {
    var token = decryptData(box.read("token"), tokenKey);
    _authService.uploadProfileImage(image, token);
  }
}
