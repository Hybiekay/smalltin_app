import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/constants/api_string.dart';
import 'package:smalltin/feature/comment/provider/comment_controller.dart';
import 'package:smalltin/feature/ladder/model/lader_user.dart';
import 'package:smalltin/themes/color.dart';
import 'package:chat_bubbles/chat_bubbles.dart'; // Import the chat_bubbles package
import 'package:intl/intl.dart'; // For formatting the date and time
import 'package:timeago/timeago.dart' as timeago; // Import timeago package

class CommentBottomSheet extends StatefulWidget {
  final MonthlyStat user;

  const CommentBottomSheet({super.key, required this.user});

  @override
  CommentBottomSheetState createState() => CommentBottomSheetState();
}

class CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  final CommentController commentController = Get.put(CommentController());
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    commentController.fetchComments(widget.user.id); // Fetch comments

    // Scroll to the last comment automatically after data is fetched
    ever(commentController.comments, (_) {
      _scrollToBottom();
    });
  }

  // Function to scroll to the bottom
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.minScrollExtent);
    }
  }

  // Function to edit comment
  void _editComment(
      BuildContext context, int commentId, String initialComment) {
    TextEditingController editController =
        TextEditingController(text: initialComment);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Comment'),
          content: TextField(
            controller: editController,
            minLines: 1,
            maxLines: 5,
            decoration: const InputDecoration(hintText: 'Update your comment'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedComment = editController.text.trim();
                if (updatedComment.isNotEmpty) {
                  commentController.updateComment(commentId, updatedComment);
                  Navigator.pop(context); // Close dialog
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // Function to show options (Edit/Delete) for the current user
  void _showEditDeleteOptions(
      BuildContext context, int commentId, String commentText) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _editComment(context, commentId, commentText);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                commentController.deleteComment(commentId);
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // User header with Avatar
            Row(
              children: [
                widget.user.userDetails.profile != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(ApiString.imageUrl(
                            widget.user.userDetails.profile ?? "")),
                        radius: 20,
                      )
                    : const CircleAvatar(radius: 20),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.user.userDetails.username),
                      Text(
                        'Correct: ${widget.user.correctAnswers}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Comments for ${widget.user.userDetails.username}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            // Comments ListView with GetX reactive state and chat bubble design
            Expanded(
              child: Obx(() {
                if (commentController.comments.isNotEmpty) {
                  return ListView.builder(
                    reverse: true, // Reverse to show the latest at the bottom
                    controller: _scrollController, // Attach scroll controller
                    itemCount: commentController.comments.length,
                    itemBuilder: (context, index) {
                      final comment = commentController.comments[index];
                      bool isCurrentUser = comment.user.id == widget.user.id;

                      // Format the date and time
                      final String formattedDate =
                          formatTimestamp(DateTime.parse(comment.createdAt));

                      return GestureDetector(
                        onLongPress: () {
                          if (isCurrentUser) {
                            _showEditDeleteOptions(
                                context, comment.id, comment.comment);
                          }
                        },
                        child: Column(
                          crossAxisAlignment: isCurrentUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            BubbleSpecialTwo(
                              text: comment.comment,
                              isSender: isCurrentUser,
                              color: isCurrentUser
                                  ? Colors.blue[100]!
                                  : Colors.grey[300]!,
                              tail: true,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black),
                              seen: true, // Customize this based on the logic
                            ),
                            // Display username and timestamp below each comment
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: isCurrentUser
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Text(comment.user.username,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 8),
                                  Text(formattedDate,
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                            const SizedBox(
                                height: 8), // Add space between comments
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No comments yet'));
                }
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
                      _scrollToBottom(); // Scroll to the last message after submitting
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

///Function to format the timestamp
String formatTimestamp(DateTime timestamp) {
  final now = DateTime.now();
  final difference = now.difference(timestamp);

  // If the difference is less than 10 days, show "time ago"
  if (difference.inDays < 10) {
    return timeago.format(timestamp);
  }

  // If more than 10 days, show the date without the year
  return DateFormat('MMM d').format(timestamp); // e.g., "Sep 12"
}
