import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/constants/api_string.dart';
import 'package:smalltin/feature/comment/provider/comment_controller.dart';
import 'package:smalltin/feature/ladder/model/lader_user.dart';
import 'package:smalltin/feature/widget/app_scaffold.dart';

class CommentEditorScreen extends StatefulWidget {
  final MonthlyStat user;

  const CommentEditorScreen({super.key, required this.user});

  @override
  CommentEditorScreenState createState() => CommentEditorScreenState();
}

class CommentEditorScreenState extends State<CommentEditorScreen> {
  final TextEditingController _commentController = TextEditingController();
  final CommentController commentController = Get.put(CommentController());

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    commentController.fetchComments(widget.user.id); // Fetch comments
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbarTitle: Row(
        children: [
          widget.user.userDetails.profile != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(ApiString.imageUrl(
                      widget.user.userDetails.profile ?? "")),
                  radius: 20,
                )
              : const CircleAvatar(
                  radius: 20,
                ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.userDetails.username,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Correct: ${widget.user.correctAnswers}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // User header with Avatar

            const SizedBox(height: 16),
            Text(
              'Comments for ${widget.user.userDetails.username}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            // Comments ListView with GetX reactive state
            Expanded(
              child: Obx(() {
                // if (commentController.isLoading.value) {
                //   return const Center(child: CircularProgressIndicator());
                // }

                return commentController.comments.isNotEmpty
                    ? ListView.builder(
                        itemCount: commentController.comments.length,
                        itemBuilder: (context, index) {
                          final comment = commentController.comments[index];
                          return ListTile(
                            title: Text(comment.comment),
                            subtitle: Text(
                                'By: ${comment.user.username}'), // Display user info
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 4.0),
                          );
                        },
                      )
                    : const Center(child: Text('No comments yet'));
              }),
            ),
            const SizedBox(height: 16),

            // Add comment row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      hintText: 'Enter your comment here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final comment = _commentController.text.trim();
                    if (comment.isNotEmpty) {
                      commentController.addComment(widget.user.id, comment);
                      _commentController.clear(); // Clear input field
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
