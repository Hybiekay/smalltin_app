import 'package:flutter/material.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';
import 'package:smalltin/widget/user_card.dart';

class Ladder extends StatelessWidget {
  const Ladder({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const UserCard();
            }),
      ),
    );
  }
}
