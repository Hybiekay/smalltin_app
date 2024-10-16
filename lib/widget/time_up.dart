import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/home/home.dart';
import 'package:smalltin/feature/ladder/controller/ladder_controller.dart';
import 'package:smalltin/themes/color.dart';
import 'package:smalltin/widget/quizbutton.dart';

import '../feature/questions/controllers/quiz_controller.dart';

class TimeUP extends StatefulWidget {
  const TimeUP({
    super.key,
    required this.data,
  });

  final Map data;

  @override
  State<TimeUP> createState() => _TimeUPState();
}

class _TimeUPState extends State<TimeUP> {
  QuizController quizController = Get.put(QuizController());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, snapshot) {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.symmetric(vertical: 20),
          height: 300,
          width: snapshot.isLargeScreen
              ? MediaQuery.sizeOf(context).width * 0.4
              : double.infinity,
          decoration: BoxDecoration(
              color: AppColor.scaffoldBg,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Text(
                widget.data["message"] == "Token expired."
                    ? 'Time Up'
                    : "Invalid", // "Time Up",
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
                widget.data["message"] == "Token expired."
                    ? "You haven't earned anything because you didn't keep to the time."
                    : widget.data["message"],
                textAlign: TextAlign.center,
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
                  Get.put(LadderController()).realtimeUpdate();
                  Get.offAll(() => const HomeScreen());
                  // Get.put(LadderController()).fetchUsers();
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
