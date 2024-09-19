import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/core/constants/api_string.dart';
import 'package:smalltin/feature/comment/comment_editor.dart';
import 'package:smalltin/feature/comment/provider/comment_controller.dart';
import 'package:smalltin/feature/ladder/model/lader_user.dart';



class CommentBottomSheet extends StatefulWidget {
  final MonthlyStat user;

  const CommentBottomSheet({Key? key, required this.user}) : super(key: key);

  @override
  CommentBottomSheetState createState() => CommentBottomSheetState();
}

class CommentBottomSheetState extends State<CommentBottomSheet> {
  final CommentController commentController = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    commentController.fetchComments(widget.user.id); // Fetch comments
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6, // 60% of the screen height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                    : CircleAvatar(
                        radius: 20,
                      ),
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

            // Comments ListView with GetX reactive state
            Expanded(
              child: Obx(() {
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
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CommentEditorScreen(
                                    user: widget.user,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : const Center(child: Text('No comments yet'));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
