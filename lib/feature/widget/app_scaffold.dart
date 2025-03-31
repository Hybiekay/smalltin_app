import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppScaffold extends StatefulWidget {
  final Widget? child;
  final Widget? appbarTitle;
  final List<Widget>? appbarActions;
  final Widget? appbarLeading;
  final double? leadingWidth;
  final bool? centerTitle;
  const AppScaffold(
      {super.key,
      this.child,
      this.appbarTitle,
      this.appbarActions,
      this.appbarLeading,
      this.leadingWidth,
      this.centerTitle});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: widget.leadingWidth,
          title: widget.appbarTitle,
          centerTitle: widget.centerTitle,
          actions: widget.appbarActions,
          leading: widget.appbarLeading),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: MediaQuery.sizeOf(context).height * 0.9,
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(50),
                topLeft: Radius.circular(50),
              ),
            ),
            child: widget.child),
      ),
    );
  }
}
