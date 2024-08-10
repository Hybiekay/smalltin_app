import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:smalltin/core/constants/api_string.dart';

class QuizApi {
  final box = GetStorage();
  Future startQuiz() async {
    var token = box.read("token");
    log("Start: $token");
    try {
      var res = await http.get(
        ApiString.endPoint("start-quiz"),
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
          'X-API-KEY': ApiString.apiquiss,
        },
      );
      // debugPrint(res.statusCode.toString());
      //  log(res.body.toString());
      return res;
    } catch (e) {
      log(e.toString());
    }
  }

  Future answerQuestion(
    String gameToken,
    String answer,
  ) async {
    var token = box.read("token");

    try {
      var res = await http.post(
        ApiString.endPoint("answer-question"),
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
          'X-API-KEY': ApiString.apiquiss,
        },
        body: {"token": gameToken, "answer": answer},
      );
      debugPrint(res.statusCode.toString());
      log(res.body.toString());
      return res;
    } catch (e) {
      log(e.toString());
    }
  }
}
