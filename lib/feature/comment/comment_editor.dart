import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smalltin/feature/comment/provider/comment_controller.dart';
import 'package:smalltin/feature/ladder/model/lader_user.dart';

class CommentEditorScreen extends StatefulWidget {
  final MonthlyStat user;

  const CommentEditorScreen({Key? key, required this.user}) : super(key: key);

  @override
  _CommentEditorScreenState createState() => _CommentEditorScreenState();
}

class _CommentEditorScreenState extends State<CommentEditorScreen> {
  final TextEditingController _commentController = TextEditingController();
  final CommentController commentController = Get.find<CommentController>();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Comment'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              final comment = _commentController.text.trim();
              if (comment.isNotEmpty) {
                commentController.addComment(widget.user.id, comment).then((_) {
                  Navigator.of(context).pop(); // Close the screen after adding comment
                });
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _commentController,
              minLines: 5,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Enter your comment here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
