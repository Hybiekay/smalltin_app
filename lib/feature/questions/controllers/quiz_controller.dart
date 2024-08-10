import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smalltin/apis/quiz.dart';
import 'package:smalltin/feature/home/home.dart';
import 'package:smalltin/themes/color.dart';

import '../model/question_model.dart';

class QuizController extends GetxController {
  Timer? timer;
  String? gameToken;
  final box = GetStorage();
  QuestionModel? questionModel;
  bool isBusy = false;
  int questionCount = 1;
  int time = 60;

  List<Map> option = [
    {"A": "Hemoglobin"},
    {"B": "Insulin"},
    {"C": "Adrenaline"},
    {"D": "Glucagon"},
  ];

  final QuizApi _quizApi = QuizApi();

  startCounting() async {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time > 1) {
        time--;
        update();
      }
    });
  }

  startQuiz() async {
    timer?.cancel();
    time = 60;
    questionCount = 1;
    option = [];
    isBusy = true;
    update();
    var res = await _quizApi.startQuiz();
    isBusy = false;
    update();
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      gameToken = data["token"];
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
    if (time == 60) {
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
      if (questionCount < 10) {
        questionCount = data["current_question_index"] + 1;
        update();
      } else {
        timer?.cancel();
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
      var data = json.decode(res.body);
      // showDialog(
      //     context: context,
      //     builder: (_) => Dialog(
      //             child: Container(
      //           child: Column(
      //             children: [
      //               Text(
      //                 data["message"],
      //               ),
      //               Text("${data["correct_count"]} / 10"),
      //               Text("You Earn ${data["correct_count"] * 50} "),
      //             ],
      //           ),
      //         )));

      Get.dialog(EndGame(data: data));
    }
  }
}

class EndGame extends StatefulWidget {
  const EndGame({
    super.key,
    required this.data,
  });

  final Map data;

  @override
  State<EndGame> createState() => _EndGameState();
}

class _EndGameState extends State<EndGame> {
  QuizController quizController = Get.put(QuizController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        padding: const EdgeInsets.symmetric(vertical: 20),
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColor.scaffoldBg,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(
              widget.data["message"],
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColor.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "${widget.data["correct_count"]} / 10",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColor.white, fontSize: 22),
            ),
            Text(
              "You Earn ${widget.data["correct_count"] * 50} ",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColor.white, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            QuizButton(
              text: "Re-Attempt",
              onTap: () {
                Get.back();
                quizController.startQuiz();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            QuizButton(
              text: "End Quiz",
              onTap: () {
                Get.offAll(() => const HomeScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}

class QuizButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const QuizButton({super.key, required this.onTap, this.text = 'Reatterm'});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColor.gray,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 35.h,
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColor.scaffoldBg,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
