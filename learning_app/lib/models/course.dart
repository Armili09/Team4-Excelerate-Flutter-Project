class Course {
  final String id;
  final String title;
  final String description;
  final String image;
  final String level;
  final double progress;
  final double rating;
  final int reviews;
  final String instructor;
  final String instructorImage;
  final List<CourseModule> modules;

  // Optional fields for UI
  final String status; // "in_progress" or "completed"
  final String startDate;
  final String endDate;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.level,
    required this.progress,
    required this.rating,
    required this.reviews,
    required this.instructor,
    required this.instructorImage,
    required this.modules,
    this.status = "in_progress",
    this.startDate = "",
    this.endDate = "",
  });

  // Factory to parse JSON from DataService
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      level: json['level'] ?? 'Beginner',
      progress: (json['progress'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      reviews: json['reviews'] ?? 0,
      instructor: json['instructor'] ?? '',
      instructorImage: json['instructorImage'] ?? '',
      status: json['status'] ?? 'in_progress',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      modules:
          (json['modules'] as List<dynamic>?)
              ?.map((m) => CourseModule.fromJson(m))
              .toList() ??
          [],
    );
  }
}

class CourseModule {
  final String title;
  final String subtitle;
  final bool completed;

  CourseModule({
    required this.title,
    required this.subtitle,
    required this.completed,
  });

  factory CourseModule.fromJson(Map<String, dynamic> json) {
    return CourseModule(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      completed: json['completed'] ?? false,
    );
  }
}
