enum CourseStatus { inProgress, saved, completed }

class Course {
  final String id;
  final String title;
  final String description;
  final double progress; // 0.0 - 1.0
  final CourseStatus status;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.status,
  });
}
