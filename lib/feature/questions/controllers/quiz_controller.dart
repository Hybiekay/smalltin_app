import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smalltin/apis/quiz.dart';
import 'package:smalltin/widget/end_game.dart';
import 'package:smalltin/widget/time_up.dart';
import '../model/question_model.dart';

class QuizController extends GetxController {
  Timer? _timer;
  String? gameToken;
  final box = GetStorage();
  QuestionModel? questionModel;
  bool isBusy = false;
  int questionCount = 1;
  int questionLength = 10;
  int time = 120;

  List<Map> option = [
    {"A": "Hemoglobin"},
    {"B": "Insulin"},
    {"C": "Adrenaline"},
    {"D": "Glucagon"},
  ];

  final QuizApi _quizApi = QuizApi();

  startCounting() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time > 1) {
        time--;
        update();
      } else {
        timer.cancel();
        _timer?.cancel();

        Get.dialog(const TimeUP(data: {"message": 'You time is up'}));
      }
    });
  }

  startQuiz() async {
    _timer?.cancel();
    time = 120;
    questionCount = 1;
    option = [];
    isBusy = true;
    update();
    var res = await _quizApi.startQuiz();
    isBusy = false;
    update();
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      log(res.body);
      gameToken = data["token"];
      update();
      questionLength = data["question_length"];
      update();

      var question = QuestionModel.fromJson(data['question']);
      questionModel = question;
      option.clear();
      option.add({"A": question.optionA});
      option.add({"B": question.optionB});
      option.add({"C": question.optionC});
      option.add({"D": question.optionD});

      update();
    }
  }

  answerQuestion({
    required String answer,
  }) async {
    if (time == 120) {
      startCounting();
    }
    isBusy = true;
    update();
    var res = await _quizApi.answerQuestion(gameToken!, answer);
    isBusy = false;
    update();
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      gameToken = data["token"];
      if (questionCount < questionLength) {
        questionCount = data["current_question_index"] + 1;
        update();
      } else {
        _timer?.cancel();
      }
      var question = QuestionModel.fromJson(data["next_question"]);
      questionModel = question;
      update();
      option.clear();
      option.add({"A": question.optionA});
      option.add({"B": question.optionB});
      option.add({"C": question.optionC});
      option.add({"D": question.optionD});

      update();
    } else if (res.statusCode == 201) {
      _timer?.cancel();
      time = 0;
      var data = json.decode(res.body);
      gameToken = data["token"];
      Get.dialog(barrierDismissible: false, EndGame(data: data));
    } else if (res.statusCode == 401) {
      _timer?.cancel();
      time = 0;
      var data = json.decode(res.body);
      Get.dialog(
        barrierDismissible: false, //
        TimeUP(data: data),
      );
    } else {}
  }
}
