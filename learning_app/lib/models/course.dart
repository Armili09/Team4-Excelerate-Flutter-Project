class Course {
  final String id;
  final String title;
  final double progress;
  final String status;
  final String startDate;
  final String endDate;
  final List<Map<String, dynamic>> modules;

  Course({
    required this.id,
    required this.title,
    required this.progress,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.modules,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      progress: (json['progress'] as num).toDouble(),
      status: json['status'],
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      modules: List<Map<String, dynamic>>.from(json['modules'] ?? []),
    );
  }
}
