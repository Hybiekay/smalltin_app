import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/auth/sign_in.dart';
import 'package:smalltin/model/user_model.dart';

class UserController extends GetxController {
  final AuthController _authService = AuthController();
  String userKey = "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6";

  UserModel? userModel;
  final box = GetStorage();
  @override
  void onInit() {
    userModel = null;
    // box.remove("user");

    update();
    var dd = box.read("user");
    if (dd != null) {
      var ff = decryptData(dd, userKey);
      var endo = json.encode(ff);
      var datsa = json.decode(endo);
      UserModel userRessponse = UserModel.fromJson(jsonDecode(datsa));

      userModel = userRessponse;
      update();
    } else {
      getUser();
    }
    super.onInit();
  }

  refreshUser() async {
    userModel = null;
    getUser();
  }

  getUser() async {
    var res = await _authService.getUser();
    if (res != null && res.statusCode == 200) {
      var data = json.decode(res.body);
      var userRessponse = UserModel.fromJson(data["data"]);
      userModel = userRessponse;
      update();
      var enc = encryptData(json.encode(data["data"]), userKey);
      await box.write("user", enc);
    } else if (res.statusCode == 401) {
      Get.to(() => const SignInScreen());
    }
  }
}
