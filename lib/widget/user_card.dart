import 'package:flutter/material.dart';
import 'package:smalltin/core/constants/app_images.dart';
import 'package:smalltin/feature/comment/comment_screen.dart';
import 'package:smalltin/feature/ladder/model/lader_user.dart';
import 'package:smalltin/widget/image_widget.dart';
import '../core/core.dart';

class UserCard extends StatelessWidget {
  final MonthlyStat user;
  final bool isCurrentUser;

  const UserCard({super.key, required this.user, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isCurrentUser
          ? Colors.green.withOpacity(0.2)
          : null, // Highlight for current user
      child: ListTile(
        title: Text(
          capitalizeFirstLetter(user.userDetails.username),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isCurrentUser
                ? Colors.white
                : null, // Text color change for current user
          ),
        ),
        subtitle: Text(
          'Correct Answers: ${user.correctAnswers}, Incorrect Answers: ${user.incorrectAnswers}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: GestureDetector(
          onTap: () => showCommentBottomSheet(context, user),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                ),
                child: ImageWidget(
                  imagePath: AppImages.message,
                  color: Theme.of(context).primaryColor,
                  width: 20,
                ),
              ),
              if ((user.commentCount ?? 0) > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Center(
                      child: Text(
                        _formatCommentCount(user.commentCount ?? 0),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to format comment count
}

String _formatCommentCount(int count) {
  if (count >= 1000) {
    final int kCount = (count / 1000).round();
    return '$kCount k';
  }
  return '$count';
}

void showCommentBottomSheet(BuildContext context, MonthlyStat user) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: CommentBottomSheet(user: user),
      );
    },
  );
}
