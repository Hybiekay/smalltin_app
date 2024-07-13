class UserModel {
  int id;
  String username;
  String email;
  int isVerified;
  String? userBio;
  int fieldId;
  dynamic subFields1;
  dynamic subFields2;
  dynamic subFields3;
  int totalQuestionAttempt;
  int totalQuestionCorrect;
  int monthQuestionAttempt;
  int monthQuestionCorrect;
  int jobs;
  DateTime? emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  UserField field;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.isVerified,
    this.userBio,
    required this.fieldId,
    this.subFields1,
    this.subFields2,
    this.subFields3,
    required this.totalQuestionAttempt,
    required this.totalQuestionCorrect,
    required this.monthQuestionAttempt,
    required this.monthQuestionCorrect,
    required this.jobs,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.field,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      isVerified: json['is_verified'],
      userBio: json['user_bio'],
      fieldId: json['field_id'],
      subFields1: json['sub_fields_1'],
      subFields2: json['sub_fields_2'],
      subFields3: json['sub_fields_3'],
      totalQuestionAttempt: json['total_question_attempt'],
      totalQuestionCorrect: json['total_question_correct'],
      monthQuestionAttempt: json['month_question_attempt'],
      monthQuestionCorrect: json['month_question_correct'],
      jobs: json['jobs'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      field: UserField.fromJson(json['field']),
    );
  }
}

class UserField {
  int id;
  String name;
  String color;
  int size;
  DateTime createdAt;
  DateTime updatedAt;

  UserField({
    required this.id,
    required this.name,
    required this.color,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserField.fromJson(Map<String, dynamic> json) {
    return UserField(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      size: json['size'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
