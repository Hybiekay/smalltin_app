import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:smalltin/core/constants/api_string.dart';
import 'package:smalltin/core/core.dart';

class QuizApi {
  final box = GetStorage();
  String tokenKey = "5f67d9a2c8e3f6b1d4e7g8h2i3j4k5l6";

  Future startQuiz() async {
    var token = decryptData(box.read("token"), tokenKey);

    try {
      var res = await http.get(
        ApiString.endPoint("start-quiz"),
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
          'X-API-KEY': ApiString.apiquiss,
        },
      );
      // log(res.statusCode.toString());
      // log(res.body.toString());
      return res;
    } catch (e) {
      log(e.toString());
    }
  }

  Future answerQuestion(
    String gameToken,
    String answer,
  ) async {
    var token = decryptData(box.read("token"), tokenKey);

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
      // debugPrint(res.statusCode.toString());

      return res;
    } catch (e) {
      log(e.toString());
    }
  }
}
