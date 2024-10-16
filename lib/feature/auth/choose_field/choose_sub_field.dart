import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/choose_field/controller/field_controller.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';
import 'package:smalltin/themes/color.dart';
import 'package:smalltin/widget/bubble.dart';
import 'package:smalltin/widget/next_button.dart';

class ChooseSubField extends StatefulWidget {
  const ChooseSubField({
    super.key,
  });

  @override
  State<ChooseSubField> createState() => _ChooseSubFieldState();
}

class _ChooseSubFieldState extends State<ChooseSubField> {
  final List<int> mainFields =
      List<int>.from(Get.arguments); // Convert arguments back to List<int>

  // Convert the comma-separated string to a list of integers

  List<int> selectedSubfields = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return GetBuilder<FieldsController>(builder: (fieldsController) {
        // Find all fields that match any of the IDs in mainField
        var fields = fieldsController.fields
            .where((element) => mainFields.contains(element.id))
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
                                        context),
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
}
