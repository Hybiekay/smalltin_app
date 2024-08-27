class LadderUser {
  final int id;
  final String username;
  final String email;
  final String? profile;
  final String? userBio;

  LadderUser({
    required this.id,
    required this.username,
    required this.email,
    required this.profile,
    this.userBio
  });

  factory LadderUser.fromJson(Map<String, dynamic> json) {
    return LadderUser(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        profile: json["profile"],
        userBio:json["user_bio"]
        );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'email': email, "profile": profile, "user_bio":userBio};
  }
}

class MonthlyStat {
  final int id;
  final int userId;
  final int correctAnswers;
  final int incorrectAnswers;
  final int totalAttempts;
  final int? monthlyJobs;
  // final String month;
  final String createdAt;
  final String updatedAt;
  final LadderUser userDetails;

  MonthlyStat({
    required this.id,
    required this.userId,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.totalAttempts,
    this.monthlyJobs,
    // required this.month,
    required this.createdAt,
    required this.updatedAt,
    required this.userDetails,
  });

  factory MonthlyStat.fromJson(Map<String, dynamic> json) {
    return MonthlyStat(
      id: json['id'],
      userId: json['user_id'],
      correctAnswers: json['correct_answers'],
      incorrectAnswers: json['incorrect_answers'],
      monthlyJobs: json["monthly_jobs"],
      totalAttempts: json['total_attempts'],
      // month: json['month'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userDetails: LadderUser.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'correct_answers': correctAnswers,
      'incorrect_answers': incorrectAnswers,
      'total_attempts': totalAttempts,
      "monthly_jobs":monthlyJobs,
      // 'month': month,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': userDetails.toJson(),
    };
  }
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}

class MonthlyStatResponse {
  final int currentPage;
  final List<MonthlyStat> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  MonthlyStatResponse({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory MonthlyStatResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<MonthlyStat> dataList =
        list.map((i) => MonthlyStat.fromJson(i)).toList();

    var linkList = json['links'] as List;
    List<Link> linkData = linkList.map((i) => Link.fromJson(i)).toList();

    return MonthlyStatResponse(
      currentPage: json['current_page'],
      data: dataList,
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: linkData,
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> dataList =
        data.map((user) => user.toJson()).toList();
    List<Map<String, dynamic>> linkList =
        links.map((link) => link.toJson()).toList();

    return {
      'current_page': currentPage,
      'data': dataList,
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': linkList,
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}
