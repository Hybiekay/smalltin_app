import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:smalltin/core/constants/api_string.dart';

import '../feature/ladder/model/lader_user.dart';

class LadderApi {
  final box = GetStorage();
  Future<MonthlyStatResponse?> getUsers(int page) async {
    var token = box.read("token");
    log("Start: $token");
    try {
      var res = await http.get(
        ApiString.endPoint("ladder?page=$page"),
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
          //'X-API-KEY': ApiString.apiquiss,
        },
      );
      debugPrint(res.statusCode.toString());
      log(res.body.toString());
      var response = json.decode(res.body);
      log("hehljdsgj c");
      var user = MonthlyStatResponse.fromJson(response["data"]);
      debugPrint("$user");
      return user;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
