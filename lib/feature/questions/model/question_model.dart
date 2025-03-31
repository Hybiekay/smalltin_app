class QuestionModel {
  final int id;
  final int fieldId;
  final int subFieldsId;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;

  QuestionModel({
    required this.id,
    required this.fieldId,
    required this.subFieldsId,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
  });

  // Factory constructor to create a Question object from JSON
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      fieldId: json['field_id'],
      subFieldsId: json['sub_fields_id'],
      question: json['question'],
      optionA: json['a'],
      optionB: json['b'],
      optionC: json['c'],
      optionD: json['d'],
    );
  }

  // Method to convert a Question object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field_id': fieldId,
      'sub_fields_id': subFieldsId,
      'question': question,
      'a': optionA,
      'b': optionB,
      'c': optionC,
      'd': optionD,
    };
  }
}
