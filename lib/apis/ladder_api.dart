import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:smalltin/core/constants/api_string.dart';
import 'package:smalltin/core/core.dart';

import '../feature/ladder/model/lader_user.dart';

class LadderApi {
  final box = GetStorage();
  String tokenKey = "5f67d9a2c8e3f6b1d4e7g8h2i3j4k5l6";

  Future<MonthlyStatResponse?> getUsers(int page) async {
    var token = decryptData(box.read("token"), tokenKey);

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
      var response = json.decode(res.body);
      var user = MonthlyStatResponse.fromJson(response["data"]);

      return user;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
