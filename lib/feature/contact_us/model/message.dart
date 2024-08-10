class Message {
  final int? id;
  final int? conversationId;
  final int? senderId;
  final String senderType;
  final String message;
  final String createdAt;
  final String updatedAt;
  final Sender sender;

  Message({
    this.id,
    this.conversationId,
    this.senderId,
    required this.senderType,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.sender,
  });

  // Convert a Message instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'sender_id': senderId,
      'sender_type': senderType,
      'message': message,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'sender': sender.toJson(),
    };
  }

  // Create a Message instance from a JSON map
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      conversationId: json['conversation_id'],
      senderId: json['sender_id'],
      senderType: json['sender_type'],
      message: json['message'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      sender: Sender.fromJson(json['sender']),
    );
  }
}

class Sender {
  final int? id;
  final String username;
  final String email;
  final String? userBio;
  final String? role;

  Sender({
    this.id,
    required this.username,
    required this.email,
    this.userBio,
    required this.role,
  });

  // Convert a Sender instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
    };
  }

  // Create a Sender instance from a JSON map
  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      username: json['username'] ?? json['user_name'],
      email: json['email'],
      role: json['role'],
    );
  }
}
