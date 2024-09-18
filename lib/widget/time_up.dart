import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              "Time Up",
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
              "You haven't earned anything because you didn't keep to the time.",
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
                Get.offAll(() => const HomeScreen());
                Get.put(LadderController()).fetchUsers();
              },
            )
          ],
        ),
      ),
    );
  }
}
