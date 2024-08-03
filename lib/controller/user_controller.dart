import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/model/user_model.dart';

class UserController extends GetxController {
  final AuthController _authService = AuthController();
  UserModel? userModel;
  final box = GetStorage();
  @override
  void onInit() {
    userModel = null;
    update();
    var ff = box.read("user");
    if (ff != null) {
      log("not null");
      UserModel userRessponse = UserModel.fromJson(ff);

      userModel = userRessponse;
      update();
      log(userRessponse.toString());
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
    var data = json.decode(res.body);
    log("${data["data"]}");
    if (res != null && res.statusCode == 200) {
      var data = json.decode(res.body);
      log("${data["data"]}");
      var userRessponse = UserModel.fromJson(data["data"]);
      userModel = userRessponse;
      update();
      await box.write("user", data["data"]);
      log("done");
    }
  }
}
