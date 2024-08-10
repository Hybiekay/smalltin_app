
// Main UserModel model
class UserModel {
  final int id;
  final String username;
  final String email;
  final bool isVerified;
  final String? userBio;
  final int totalQuestionAttempt;
  final int totalQuestionCorrect;
  final int jobs;
  final DateTime emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Field> fields; // Non-nullable list
  final List<SubField> subfields; // Non-nullable list

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.isVerified,
    this.userBio,
    required this.totalQuestionAttempt,
    required this.totalQuestionCorrect,
    required this.jobs,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.fields, // Non-nullable list
    required this.subfields, // Non-nullable list
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      isVerified: json['is_verified'] == 1,
      userBio: json['user_bio'],
      totalQuestionAttempt: json['total_question_attempt'],
      totalQuestionCorrect: json['total_question_correct'],
      jobs: json['jobs'],
      emailVerifiedAt: DateTime.parse(json['email_verified_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      fields: (json['fields'] as List<dynamic>?)
              ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [], // Handle empty array
      subfields: (json['subfields'] as List<dynamic>?)
              ?.map((e) => SubField.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [], // Handle empty array
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'is_verified': isVerified ? 1 : 0,
      'user_bio': userBio,
      'total_question_attempt': totalQuestionAttempt,
      'total_question_correct': totalQuestionCorrect,
      'jobs': jobs,
      'email_verified_at': emailVerifiedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'fields': fields.map((e) => e.toJson()).toList(),
      'subfields': subfields.map((e) => e.toJson()).toList(),
    };
  }
}

// Field model
class Field {
  final int id;
  final String name;
  final String color;
  final int size;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pivot pivot;

  Field({
    required this.id,
    required this.name,
    required this.color,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      size: json['size'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      pivot: Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'size': size,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'pivot': pivot.toJson(),
    };
  }
}

// SubField model
class SubField {
  final int id;
  final int fieldId;
  final String name;
  final String color;
  final int size;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pivot pivot;

  SubField({
    required this.id,
    required this.fieldId,
    required this.name,
    required this.color,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory SubField.fromJson(Map<String, dynamic> json) {
    return SubField(
      id: json['id'],
      fieldId: json['field_id'],
      name: json['name'],
      color: json['color'],
      size: json['size'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      pivot: Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field_id': fieldId,
      'name': name,
      'color': color,
      'size': size,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'pivot': pivot.toJson(),
    };
  }
}

// Pivot model used in both Field and SubField
class Pivot {
  final int userId;
  final int? fieldId;
  final int? subFieldId;

  Pivot({
    required this.userId,
    this.fieldId,
    this.subFieldId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      userId: json['user_id'],
      fieldId: json['field_id'],
      subFieldId: json['sub_field_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'field_id': fieldId,
      'sub_field_id': subFieldId,
    };
  }
}
