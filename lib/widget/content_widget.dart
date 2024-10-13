import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smalltin/core/core.dart';

class ContentWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const ContentWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, snapshot) {
      return SizedBox(
        width: snapshot.isLargeScreen
            ? MediaQuery.sizeOf(context).width * 0.4
            : null,
        child: Column(
          crossAxisAlignment: snapshot.isLargeScreen
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            snapshot.isLargeScreen
                ? SizedBox(
                    height: 60.h,
                  )
                : Container(),
            Image.asset(
              getLogo(context),
              height: snapshot.isLargeScreen ? 250.h : null,
            ),
            SizedBox(
              height: 40.h,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 10.h),
            Text(
              subTitle,
              textAlign:
                  snapshot.isLargeScreen ? TextAlign.left : TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            snapshot.isPhoneScreen
                ? SizedBox(
                    height: 30.h,
                  )
                : Container(),
          ],
        ),
      );
    });
  }
}
