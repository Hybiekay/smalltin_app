import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/comment.dart';

class CommentController extends GetxController {
  RxBool isLoading = false.obs;
  // Use RxList to make the comments list observable
  RxList<Comment> comments = <Comment>[].obs;

  // Fetch all comments for a specific MonthlyStat
  Future<void> fetchComments(int monthlyStatId) async {
    final url = 'https://yourapi.com/monthly-stats/$monthlyStatId/comments';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> commentData = json.decode(response.body);
      comments.value =
          commentData.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // Add a new comment
  Future<void> addComment(int monthlyStatId, String commentText) async {
    final url = 'https://yourapi.com/monthly-stats/$monthlyStatId/comments';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'comment': commentText}),
    );

    if (response.statusCode == 201) {
      final newComment = Comment.fromJson(json.decode(response.body));
      comments.add(newComment); // Automatically updates UI since it's an RxList
    } else {
      throw Exception('Failed to add comment');
    }
  }

  // Update an existing comment
  Future<void> updateComment(int commentId, String updatedText) async {
    final url = 'https://yourapi.com/comments/$commentId';
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'comment': updatedText}),
    );

    if (response.statusCode == 200) {
      final updatedComment = Comment.fromJson(json.decode(response.body));
      final index = comments.indexWhere((comment) => comment.id == commentId);
      if (index != -1) {
        comments[index] = updatedComment;
      }
    } else {
      throw Exception('Failed to update comment');
    }
  }

  // Delete a comment
  Future<void> deleteComment(int commentId) async {
    final url = 'https://yourapi.com/comments/$commentId';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      comments.removeWhere((comment) => comment.id == commentId);
    } else {
      throw Exception('Failed to delete comment');
    }
  }
}
