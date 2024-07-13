import 'package:flutter/material.dart';

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

  static error({
    required BuildContext context,
    String? title,
    String? buttonText,
    VoidCallback? onPressed,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title ?? "Error",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        actions: [
          GestureDetector(
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              height: 40,
              child: Center(
                child: Text(
                  buttonText ?? "Ok",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
