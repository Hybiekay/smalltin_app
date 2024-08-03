import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/choose_field/controller/field_controller.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';
import 'package:smalltin/themes/color.dart';
import 'package:smalltin/widget/next_button.dart';

import '../../../core/constants/app_images.dart';

class ChooseSubField extends StatefulWidget {
  final List<int> mainField;
  const ChooseSubField({super.key, required this.mainField});

  @override
  State<ChooseSubField> createState() => _ChooseSubFieldState();
}

class _ChooseSubFieldState extends State<ChooseSubField> {
  List<int> selectedSubfields = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return GetBuilder<FieldsController>(builder: (fieldsController) {
        // Find all fields that match any of the IDs in mainField
        var fields = fieldsController.fields
            .where((element) => widget.mainField.contains(element.id))
            .toList();

        // Aggregate all subfields from the matching fields
        var subFields =
            fields.expand((field) => field.subFields ?? []).toList();

        return AppScaffold(
          appbarTitle: Text(
            'Choose Subfields',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: !context.isDarkMode ? AppColor.white : null),
          ),
          appbarActions: [
            NextButton(onTap: () {
              if (selectedSubfields.isEmpty || selectedSubfields.length < 2) {
                Get.snackbar("Field is Required", "Select At least 2",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor);
              } else {
                authController.updateSubFields(
                    context: context, subFields: selectedSubfields);
              }
            }),
          ],
          child: authController.isBusy
              ? const Loading()
              : Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 17.0, // Space between bubbles horizontally
                          runSpacing: 7.0, // Space between bubbles vertically
                          children: subFields
                              .map((bub) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (selectedSubfields
                                            .contains(bub.id)) {
                                          selectedSubfields.remove(bub.id);
                                        } else {
                                          selectedSubfields.add(bub.id);
                                        }
                                      });
                                    },
                                    child: bubble(
                                      bub.name,
                                      getColorFromHex(bub.color),
                                      bub.size.toDouble(),
                                      selectedSubfields.contains(bub.id),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      });
    });
  }

  Widget bubble(String text, Color color, double size, bool isSelected) {
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
        color: isSelected ? AppColor.gray : color,
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          Center(
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
          if (isSelected)
            const Positioned(
              right: 5,
              bottom: 5,
              child: Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
