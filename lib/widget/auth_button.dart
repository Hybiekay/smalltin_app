import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smalltin/core/core.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onTap;
  const AuthButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, snapshot) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: snapshot.isLargeScreen ? 90 : 90.w,
          height: snapshot.isLargeScreen
              ? 50
              : kIsWeb
                  ? 60
                  : 40.h,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.keyboard_double_arrow_right_outlined,
            size: 30,
          ),
        ),
      );
    });
  }
}
