class Certificate {
  final String id;
  final String courseTitle;
  final String courseName;
  final String recipientName;
  final DateTime completionDate;
  final DateTime issueDate;
  final String certificateUrl;
  final String verificationCode;
  final String issuer;
  final double score;
  final int creditsEarned;
  final String templateType;

  Certificate({
    required this.id,
    required this.courseTitle,
    required this.courseName,
    required this.recipientName,
    required this.completionDate,
    required this.issueDate,
    required this.certificateUrl,
    required this.verificationCode,
    required this.issuer,
    required this.score,
    required this.creditsEarned,
    this.templateType = 'standard',
  });

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['id'] ?? '',
      courseTitle: json['courseTitle'] ?? '',
      courseName: json['courseName'] ?? '',
      recipientName: json['recipientName'] ?? '',
      completionDate: DateTime.parse(json['completionDate'] ?? DateTime.now().toIso8601String()),
      issueDate: DateTime.parse(json['issueDate'] ?? DateTime.now().toIso8601String()),
      certificateUrl: json['certificateUrl'] ?? '',
      verificationCode: json['verificationCode'] ?? '',
      issuer: json['issuer'] ?? 'Excelerate Learning',
      score: (json['score'] ?? 0).toDouble(),
      creditsEarned: json['creditsEarned'] ?? 0,
      templateType: json['templateType'] ?? 'standard',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseTitle': courseTitle,
      'courseName': courseName,
      'recipientName': recipientName,
      'completionDate': completionDate.toIso8601String(),
      'issueDate': issueDate.toIso8601String(),
      'certificateUrl': certificateUrl,
      'verificationCode': verificationCode,
      'issuer': issuer,
      'score': score,
      'creditsEarned': creditsEarned,
      'templateType': templateType,
    };
  }
}
