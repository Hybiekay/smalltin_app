import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Import GetStorage
import 'package:http/http.dart' as http;
import 'package:smalltin/core/constants/api_string.dart';
import 'package:smalltin/core/core.dart';
import 'dart:convert';

import '../../../controller/user_controller.dart';
import '../model/comment.dart';

class CommentController extends GetxController {
  RxList<Comment> comments = <Comment>[].obs;
  final box = GetStorage();
  String tokenKey = "5f67d9a2c8e3f6b1d4e7g8h2i3j4k5l6";
  dynamic token;
  @override
  void onInit() {
    super.onInit();
    token = decryptData(box.read("token"), tokenKey);
  }

  final UserController userController = Get.put(UserController());

  Future<void> fetchComments(int monthlyStatId) async {
    final url = ApiString.endPoint('monthly-stats/$monthlyStatId/comments');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Add the token here
      },
    );
    log(response.statusCode.toString());
    log(response.body.toString());

    if (response.statusCode == 200) {
      final List<dynamic> commentData = json.decode(response.body)["comments"];
      comments.value =
          commentData.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // Add a new comment
  Future<void> addComment(int monthlyStatId, String commentText) async {
    final url = ApiString.endPoint('monthly-stats/$monthlyStatId/comments');

    // Add Authorization header
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Add the token here
      },
      body: json.encode({'comment': commentText}),
    );
    log(response.body.toString());
    log(response.statusCode.toString());

    if (response.statusCode == 201) {
      final data = json.decode(response.body)["data"];
      final newComment = Comment(
          comment: data["comment"],
          id: data["id"],
          createdAt: data['created_at'],
          user: User(
              id: userController.userModel?.id ?? 1,
              username: userController.userModel?.username ?? "user"));

      comments.insert(
          0, newComment); // Automatically updates UI since it's an RxList
    } else {
      throw Exception('Failed to add comment');
    }
  }

  // Update an existing comment
  Future<void> updateComment(int commentId, String updatedText) async {
    final url = ApiString.endPoint('comments/$commentId');

    // Add Authorization header
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Add the token here
      },
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
    final url = ApiString.endPoint('comments/$commentId');

    // Add Authorization header
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Add the token here
      },
    );

    if (response.statusCode == 200) {
      comments.removeWhere((comment) => comment.id == commentId);
    } else {
      throw Exception('Failed to delete comment');
    }
  }
}
