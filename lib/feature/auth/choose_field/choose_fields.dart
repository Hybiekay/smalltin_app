import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/feature/auth/choose_field/controller/field_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import '../../../core/core.dart';
import 'choose_sub_field.dart';

class ChooseField extends StatefulWidget {
  const ChooseField({super.key});

  @override
  State<ChooseField> createState() => _ChooseFieldState();
}

class _ChooseFieldState extends State<ChooseField> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbarTitle: const Text(
        "Choose Your Feild",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      child: GetBuilder<FieldsController>(builder: (fieldsContronller) {
        return RefreshIndicator(
          onRefresh: () async {
            await fieldsContronller.refreshfields();
          },
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 17.0, // Space between bubbles horizontally
              runSpacing: 7.0, // Space between bubbles vertically
              children: fieldsContronller.fields
                  .map((bub) => GestureDetector(
                      onTap: () {
                        Get.to(() => ChooseSubField(mainField: bub.id));
                      },
                      child: bubble(bub.name, getColorFromHex(bub.color),
                          bub.size.toDouble())))
                  .toList(),
            ),
          ),
        );
      }),
    );
  }

  Widget bubble(String text, Color color, double size) {
    return Container(
      width: size < 70
          ? 70
          : size > 140
              ? 150
              : size,
      height: size < 70
          ? 70
          : size > 140
              ? 140
              : size,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          softWrap: true,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

List<Map> bubbles = [
  {'text': 'Physics', 'color': Colors.yellow, 'size': 80.0},
  {'text': 'Computer Science', 'color': Colors.pink, 'size': 100.0},
  {'text': 'Biology', 'color': Colors.blue, 'size': 70.0},
  {'text': 'Boxing', 'color': Colors.blue, 'size': 60.0},
  {'text': 'Geography', 'color': Colors.yellow, 'size': 90.0},
  {'text': 'Engineering', 'color': Colors.pink, 'size': 100.0},
  {'text': 'Mathematics', 'color': Colors.yellow, 'size': 85.0},
  {'text': 'Arts', 'color': Colors.blue, 'size': 75.0},
  {'text': 'Tennis', 'color': Colors.green, 'size': 65.0},
  {'text': 'Health', 'color': Colors.blue, 'size': 70.0},
  {'text': 'Sports', 'color': Colors.yellow, 'size': 80.0},
  {'text': 'Politics', 'color': Colors.yellow, 'size': 75.0},
  {'text': 'Geography', 'color': Colors.pink, 'size': 90.0},
  {'text': 'Environment', 'color': Colors.pink, 'size': 85.0},
  {'text': 'Global Affairs', 'color': Colors.blue, 'size': 80.0},
  {'text': 'Music', 'color': Colors.blue, 'size': 70.0},
  {'text': 'Investments', 'color': Colors.yellow, 'size': 75.0},
  {'text': 'Cinema', 'color': Colors.blue, 'size': 60.0},
  {'text': 'Syntax', 'color': Colors.blue, 'size': 65.0},
  {'text': 'Basketball', 'color': Colors.pink, 'size': 85.0},
  {'text': 'Economy', 'color': Colors.blue, 'size': 70.0},
  {'text': 'Entrepreneurship', 'color': Colors.yellow, 'size': 120.0},
  {'text': 'Cricket', 'color': Colors.green, 'size': 75.0},
  {'text': 'Film', 'color': Colors.pink, 'size': 55.0},
];
