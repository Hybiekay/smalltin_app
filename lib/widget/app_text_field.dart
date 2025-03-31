import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/core.dart';
import 'package:smalltin/themes/color.dart';
import 'package:smalltin/widget/auth_button.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final VoidCallback onTap;
  final bool isPassword;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  const AppTextField({
    super.key,
    required this.onTap,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isObucure = true;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, snapshot) {
      return Container(
        alignment: Alignment.center,
        width: snapshot.isLargeScreen
            ? MediaQuery.sizeOf(context).width * 0.4
            : double.infinity,
        height: snapshot.isLargeScreen
            ? 50
            : kIsWeb
                ? 60
                : 40.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                obscureText: widget.isPassword ? isObucure : false,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                onChanged: widget.onChanged,
                controller: widget.controller,
                style: Theme.of(context).textTheme.bodySmall,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 13),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isObucure = !isObucure;
                      });
                    },
                    child: Icon(
                      isObucure ? Icons.visibility : Icons.visibility_off,
                      color: context.isDarkMode ? AppColor.gray : Colors.black,
                    ))
                : Container(),
            const SizedBox(
              width: 10,
            ),
            AuthButton(onTap: widget.onTap),
          ],
        ),
      );
    });
  }
}
