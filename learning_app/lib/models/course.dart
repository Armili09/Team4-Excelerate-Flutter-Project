class Course {
  final String id;
  final String title;
  final double progress;
  final String status;

  Course({
    required this.id,
    required this.title,
    required this.progress,
    required this.status,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      progress: (json['progress'] as num).toDouble(),
      status: json['status'],
    );
  }
}
