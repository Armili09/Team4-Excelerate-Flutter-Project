import 'dart:async';

class DataService {
  /// Simulated profile fetch
  Future<Map<String, dynamic>> fetchUserProfile() async {
    await Future.delayed(const Duration(seconds: 1));

    return {
      "name": "Armili Paturi",
      "avatarUrl": "https://i.pravatar.cc/150",
      "bio": "Learning enthusiast & Flutter developer",
      "email": "armili@email.com",
      "education": "BS Computer Science",
      "skills": ["Flutter", "Dart", "UI/UX"],
      "interests": ["Mobile Apps", "Cloud", "AI"],
      "completedCourses": 4,
    };
  }

  /// Simulated enrolled courses fetch
  Future<List<Map<String, dynamic>>> fetchMyCourses() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      {
        "id": "c1",
        "title": "Flutter Basics",
        "progress": 0.75,
        "status": "in_progress",
      },
      {
        "id": "c2",
        "title": "Advanced Dart",
        "progress": 0.4,
        "status": "in_progress",
      },
      {
        "id": "c3",
        "title": "Cloud Fundamentals",
        "progress": 1.0,
        "status": "completed",
      },
    ];
  }
}
