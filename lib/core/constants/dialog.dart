import 'package:flutter/material.dart';
import 'package:smalltin/themes/color.dart';

class AppDailog {
  static succes({
    required BuildContext context,
    String? title,
    required String message,
  }) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                title ?? "Success",
                textAlign: TextAlign.center,
              ),
              content: Text(
                message,
                textAlign: TextAlign.center,
              ),
            ));
  }

  static endQuiz({
    required BuildContext context,
    String? title,
    required String message,
  }) {
   
    
  }

  static error({
    required BuildContext context,
    String? title,
    String? buttonText,
    VoidCallback? onPressed,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (_) => ErorrWidget(
        message: message,
        onPressed: onPressed,
        buttonText: buttonText,
        title: title,
      ),
    );
  }
}

// ignore: must_be_immutable
class ErorrWidget extends StatefulWidget {
  String? title;
  String? buttonText;
  VoidCallback? onPressed;
  final String message;
  ErorrWidget({
    super.key,
    required this.message,
    this.title,
    this.buttonText,
    this.onPressed,
  });

  @override
  State<ErorrWidget> createState() => _ErorrWidgetState();
}

class _ErorrWidgetState extends State<ErorrWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title ?? "Error",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        widget.message,
        textAlign: TextAlign.center,
      ),
      actions: [
        GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            height: 40,
            child: Center(
              child: Text(
                widget.buttonText ?? "Ok",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.gray),
              ),
            ),
          ),
        )
      ],
    );
  }
}
