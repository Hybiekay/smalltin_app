import 'package:flutter/material.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/themes/color.dart';
import 'package:smalltin/widget/appbar_button.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool? answer;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      centerTitle: false,
      leadingWidth: 0.0,
      appbarLeading: const Center(),
      appbarTitle: Row(
        children: [
          const AppBarButton(
            title: "Total Job\$",
            subTitle: "500\$",
          ),
          Text(
            "Question 7 of 10",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
      appbarActions: const [
        AppBarButton(
          title: "Total Job\$",
          subTitle: "500\$",
        )
      ],
      child: Column(
        children: [
          const SizedBox(height: 25),
          Container(
            height: 320,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.gray.withOpacity(0.3),
            ),
            child: const Center(
              child: Text(""),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: option.length,
              itemBuilder: (context, index) {
                Map opt = option[index];

                return OptionCard(
                  opt: opt,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class OptionCard extends StatefulWidget {
  const OptionCard({
    super.key,
    required this.opt,
  });

  final Map opt;

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  bool? answer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.opt.keys.first == "A") {
          setState(() {
            answer = true;
          });
        } else {
          setState(() {
            answer = false;
          });
        }
      },
      child: Container(
        height: 64,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: answer == true
                ? AppColor.scaffoldBg.withOpacity(0.3)
                : answer == false
                    ? AppColor.pColor
                    : null),
        child: Row(
          children: [
            Text(
              "${widget.opt.keys.first} ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "${widget.opt.values.first}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Expanded(child: SizedBox()),
            answer == null
                ? Container()
                : answer == true
                    ? const Icon(Icons.check)
                    : const Icon(Icons.dangerous)
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
