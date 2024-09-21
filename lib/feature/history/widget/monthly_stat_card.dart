import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'package:smalltin/core/constants/app_images.dart';
import 'package:smalltin/feature/comment/comment_view.dart';
import 'package:smalltin/feature/history/model/history_stat.dart';
import 'package:smalltin/widget/image_widget.dart';

class MonthlyStatCard extends StatelessWidget {
  final HistoryStat historyStat;

  const MonthlyStatCard({
    super.key,
    required this.historyStat,
  });

  @override
  Widget build(BuildContext context) {
    String formattedMonth = _formatCreatedAt(historyStat.createdAt);

    return Card(
      color: historyStat.win
          ? Colors.green.withOpacity(0.2)
          : null, // Highlight for current user
      child: ListTile(
        title: Text(
          formattedMonth,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: historyStat.win
                ? Colors.white
                : null, // Text color change for current user
          ),
        ),
        subtitle: Text(
          'Correct Answers: ${historyStat.correctAnswers}, Incorrect Answers: ${historyStat.incorrectAnswers}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: GestureDetector(
          onTap: () => showCommentBottomSheet(context, historyStat),
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
              if ((0) > 0)
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
                        _formatCommentCount(0),
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

  String _formatCreatedAt(DateTime createdAt) {
    final currentYear = DateTime.now().year;
    final monthFormat = DateFormat('MMMM'); // Full month name

    if (createdAt.year == currentYear) {
      return monthFormat.format(createdAt);
    } else {
      final yearFormat = DateFormat('MMMM yyyy'); // Full month and year
      return yearFormat.format(createdAt);
    }
  }

  String _formatCommentCount(int count) {
    if (count >= 1000) {
      final int kCount = (count / 1000).round();
      return '$kCount k';
    }
    return '$count';
  }
}

void showCommentBottomSheet(BuildContext context, HistoryStat monthlyStat) {
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
        height: MediaQuery.of(context).size.height * 0.8,
        child: CommentBottomView(
            user: monthlyStat), // Adjust based on your implementation
      );
    },
  );
}
