import 'package:flutter/material.dart';
import 'package:smalltin/feature/ladder/model/lader_user.dart';

import '../core/core.dart';

class UserCard extends StatelessWidget {
  final MonthlyStat user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(capitalizeFirstLetter(user.userDetails.username)),
        subtitle: Text(
            'Correct Answers: ${user.correctAnswers}, Incorrect Answers: ${user.incorrectAnswers}'),
      ),
    );
  }
}
