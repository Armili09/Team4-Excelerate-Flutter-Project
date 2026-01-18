class Program {
  final String id;
  final String title;
  final String description;
  final String category;
  final String difficulty;
  final int durationInWeeks;
  final String imageUrl;
  final List<String> skills;
  final int enrolledCount;
  final double rating;
  final bool requiresApplication;
  final String? applicationStatus;
  final List<Course> courses;

  Program({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.durationInWeeks,
    required this.imageUrl,
    required this.skills,
    required this.enrolledCount,
    required this.rating,
    this.requiresApplication = false,
    this.applicationStatus,
    this.courses = const [],
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      difficulty: json['difficulty'] ?? 'Beginner',
      durationInWeeks: json['durationInWeeks'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      enrolledCount: json['enrolledCount'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      requiresApplication: json['requiresApplication'] ?? false,
      applicationStatus: json['applicationStatus'],
      courses: (json['courses'] as List<dynamic>?)
              ?.map((c) => Course.fromJson(c))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'durationInWeeks': durationInWeeks,
      'imageUrl': imageUrl,
      'skills': skills,
      'enrolledCount': enrolledCount,
      'rating': rating,
      'requiresApplication': requiresApplication,
      'applicationStatus': applicationStatus,
      'courses': courses.map((c) => c.toJson()).toList(),
    };
  }
}

class Course {
  final String id;
  final String title;
  final String description;
  final int durationInHours;
  final String instructor;
  final String? programId;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.durationInHours,
    required this.instructor,
    this.programId,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      durationInHours: json['durationInHours'] ?? 0,
      instructor: json['instructor'] ?? '',
      programId: json['programId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'durationInHours': durationInHours,
      'instructor': instructor,
      'programId': programId,
    };
  }
}
