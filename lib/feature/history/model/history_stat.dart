class HistoryStat {
  final int id;
  final int userId;
  final int correctAnswers;
  final int incorrectAnswers;
  final int totalAttempts;
  final int monthlyJobs;
  final bool win; // Change to bool
  final String month;
  final DateTime createdAt;
  final DateTime updatedAt;

  HistoryStat({
    required this.id,
    required this.userId,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.totalAttempts,
    required this.monthlyJobs,
    required this.win,
    required this.month,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HistoryStat.fromJson(Map<String, dynamic> json) {
    return HistoryStat(
      id: json['id'],
      userId: json['user_id'],
      correctAnswers: json['correct_answers'],
      incorrectAnswers: json['incorrect_answers'],
      totalAttempts: json['total_attempts'],
      monthlyJobs: json['monthly_jobs'],
      win: json['win'] == 1, // Convert 0/1 to true/false
      month: json['month'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'correct_answers': correctAnswers,
      'incorrect_answers': incorrectAnswers,
      'total_attempts': totalAttempts,
      'monthly_jobs': monthlyJobs,
      'win': win ? 1 : 0, // Convert true/false to 1/0
      'month': month,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
