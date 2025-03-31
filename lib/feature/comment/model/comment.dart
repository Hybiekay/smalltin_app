class Comment {
  final int id;
  final String comment;
  final String createdAt;
  final User user;

  Comment({
    required this.id,
    required this.comment,
    required this.createdAt,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      comment: json['comment'],
      createdAt: json['created_at'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String username;

  User({
    required this.id,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
    );
  }
}
