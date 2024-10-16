import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/feature/auth/choose_field/controller/field_controller.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';
import 'package:smalltin/themes/color.dart';
import 'package:smalltin/widget/bubble.dart';
import 'package:smalltin/widget/next_button.dart';
import '../../../core/core.dart';

class ChooseField extends StatefulWidget {
  const ChooseField({super.key});

  @override
  State<ChooseField> createState() => _ChooseFieldState();
}

class _ChooseFieldState extends State<ChooseField> {
  List<int> selectedfields = [];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return AppScaffold(
        appbarTitle: Text(
          "Choose Your Field",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: !context.isDarkMode ? AppColor.white : null),
        ),
        appbarActions: [
          NextButton(onTap: () {
            if (selectedfields.isEmpty || selectedfields.length < 6) {
              Get.snackbar("Field is Required", "Select At least 6",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor);
            } else {
              authController.updateFields(
                context: context,
                field: selectedfields,
              );
            }
          }),
        ],
        child: authController.isBusy
            ? const Loading()
            : GetBuilder<FieldsController>(builder: (fieldsContronller) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await fieldsContronller.refreshfields();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 17.0, // Space between bubbles horizontally
                          runSpacing: 7.0, // Space between bubbles vertically
                          children: fieldsContronller.fields
                              .map((bub) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedfields.contains(bub.id)) {
                                        selectedfields.remove(bub.id);
                                      } else {
                                        selectedfields.add(bub.id);
                                      }
                                    });
                                    //  Get.to(() => ChooseSubField(mainField: bub.id));
                                  },
                                  child: bubble(
                                      bub.name,
                                      getColorFromHex(bub.color),
                                      bub.size.toDouble(),
                                      selectedfields.contains(bub.id),
                                      context)))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
      );
    });
  }
}
