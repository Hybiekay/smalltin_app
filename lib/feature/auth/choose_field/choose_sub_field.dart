import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/feature/auth/choose_field/controller/field_controller.dart';
import 'package:smalltin/feature/auth/controller/auth_controller.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';

import '../../../core/constants/app_images.dart';

class ChooseSubField extends StatefulWidget {
  final int mainField;
  const ChooseSubField({super.key, required this.mainField});

  @override
  State<ChooseSubField> createState() => _ChooseSubFieldState();
}

class _ChooseSubFieldState extends State<ChooseSubField> {
  List selectedSubfields = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuhtController>(builder: (authController) {
      return GetBuilder<FieldsController>(builder: (fieldsController) {
        var field = fieldsController.fields
            .where((element) => element.id == widget.mainField)
            .first;
        return AppScaffold(
          appbarTitle: Text(
            field.name,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          child: GetBuilder<FieldsController>(builder: (fieldsController) {
            var field = fieldsController.fields
                .where((element) => element.id == widget.mainField)
                .first;
            var subFields = field.subFields;

            return authController.isBusy
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
                            children: subFields!
                                .map((bub) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (selectedSubfields
                                              .contains(bub.name)) {
                                            selectedSubfields.remove(bub.name);
                                          } else {
                                            selectedSubfields.add(bub.name);
                                          }
                                        });
                                      },
                                      child: bubble(
                                        bub.name,
                                        getColorFromHex(bub.color),
                                        bub.size.toDouble(),
                                        selectedSubfields.contains(bub.name),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            authController.updateFields(
                                context: context,
                                field: widget.mainField,
                                subFields: selectedSubfields);
                          },
                          child: Container(
                            width: 110.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(AppImages.iconArrowForward),
                          ),
                        ),
                      ),
                    ],
                  );
          }),
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
        color: color,
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
