import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/questions/controllers/quiz_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';
import 'package:smalltin/themes/color.dart';
import 'package:smalltin/widget/appbar_button.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final QuizController controller = Get.put(QuizController());
  bool? answer;

  @override
  void initState() {
    controller.startQuiz();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(builder: (quizController) {
      return AppScaffold(
        centerTitle: false,
        leadingWidth: 0.0,
        appbarLeading: const Center(),
        appbarTitle: Row(
          children: [
            AppBarButton(
              title: "Timer",
              subTitle: formatTime(quizController.time),
            ),
            Text(
              "Question ${quizController.questionCount} of 10",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
            )
          ],
        ),
        appbarActions: const [
          // AppBarButton(
          //   title: "Total Job\$",
          //   subTitle: "500\$",
          // )
        ],
        child: quizController.isBusy
            ? const Loading()
            : Column(
                children: [
                  const SizedBox(height: 25),
                  Container(
                    height: 320,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.gray.withOpacity(0.3),
                    ),
                    child: Center(
                      child: Text(
                        quizController.questionModel?.question ??
                            "No question available for your field",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                      child: ListView.builder(
                    itemCount: quizController.option.length,
                    itemBuilder: (context, index) {
                      Map opt = quizController.option[index];
                      return OptionCard(
                        opt: opt,
                        onTap: () {
                          quizController.answerQuestion(
                            answer: opt.keys.first.toString().toLowerCase(),
                          );
                        },
                      );
                    },
                  ))
                ],
              ),
      );
    });
  }
}

class OptionCard extends StatefulWidget {
  const OptionCard({
    super.key,
    required this.opt,
    this.onTap,
  });

  final Map opt;
  final VoidCallback? onTap;

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 64,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              "${widget.opt.keys.first} )  ",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
            ),
            SizedBox(
              width: 255.w,
              child: Text(
                "${widget.opt.values.first}",
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 15),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

List option = [
  {"A": "Hemoglobin"},
  {"B": "Insulin"},
  {"C": "Adrenaline"},
  {"D": "Glucagon"},
];
