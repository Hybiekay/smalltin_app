import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/ads/reward_ads_manager.dart';
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
  final RewardedAdManager _rewardedAdManager = RewardedAdManager();
  bool _isAdWatched = false;
  @override
  void initState() {
    controller.startQuiz();
    _rewardedAdManager.loadRewardedAd();
    _attemptQuiz();
    super.initState();
  }

  void _attemptQuiz() {
    if (!_isAdWatched) {
      _rewardedAdManager.showRewardedAd(() {
        // User watched the ad, now allow them to answer questions
        setState(() {
          _isAdWatched = true;
        });
      });
    } else {
      // Proceed with the quiz logic
      // You can allow users to answer the questions now.
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(builder: (quizController) {
      return LayoutBuilder(builder: (context, snapshot) {
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
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 15),
              )
            ],
          ),
          appbarActions: const [],
          child: !_isAdWatched
              ? Container(
                  child: Center(
                    child: Text("Check Your Internet"),
                  ),
                )
              : quizController.isBusy
                  ? const Loading()
                  : snapshot.isLargeScreen
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 320,
                              width: MediaQuery.sizeOf(context).width * 0.4,
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
                            // Remove Expanded here
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: 320,
                              child: ListView.builder(
                                itemCount: quizController.option.length,
                                itemBuilder: (context, index) {
                                  Map opt = quizController.option[index];
                                  return OptionCard(
                                    opt: opt,
                                    onTap: () {
                                      quizController.answerQuestion(
                                        answer: opt.keys.first
                                            .toString()
                                            .toLowerCase(),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        )
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
                                        answer: opt.keys.first
                                            .toString()
                                            .toLowerCase(),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
        );
      });
    });
  }
}

// OptionCard remains unchanged

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
    return LayoutBuilder(builder: (context, snapshot) {
      return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 64,
          width: snapshot.isLargeScreen
              ? MediaQuery.sizeOf(context).width * 0.36
              : double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Text(
                "${widget.opt.keys.first} )  ",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 15),
              ),
              SizedBox(
                width: snapshot.isLargeScreen
                    ? MediaQuery.sizeOf(context).width * 0.36
                    : 255,
                child: Text(
                  "${widget.opt.values.first}",
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15),
                ),
              ),
              snapshot.isLargeScreen
                  ? const Expanded(child: SizedBox())
                  : const SizedBox(),
            ],
          ),
        ),
      );
    });
  }
}
