import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final String title;
  final String subTitle;
  const AppBarButton({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 92,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            subTitle,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
