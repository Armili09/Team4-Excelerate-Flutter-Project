import 'dart:async';

class DataService {
  /// Simulated profile fetch
  Future<Map<String, dynamic>> fetchUserProfile() async {
    await Future.delayed(const Duration(seconds: 1));

    return {
      "name": "Peter Parker",
      "avatarUrl":
          "https://static.wikia.nocookie.net/p__/images/c/cf/Takopi_anime1.png/revision/latest?cb=20250630020546&path-prefix=protagonist",
      "bio": "Learning enthusiast & Flutter developer",
      "email": "spider@email.com",
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
        "startDate": "Jan 1, 2024",
        "endDate": "Jan 15, 2024",
        "modules": [
          {"title": "Widgets", "completed": true},
          {"title": "State Management", "completed": false},
        ],
      },
      {
        "id": "c2",
        "title": "Advanced Dart",
        "progress": 0.4,
        "status": "in_progress",
        "startDate": "Feb 1, 2024",
        "endDate": "Feb 20, 2024",
        "modules": [
          {"title": "Generics", "completed": true},
          {"title": "Asynchronous Dart", "completed": false},
        ],
      },
      {
        "id": "c3",
        "title": "Cloud Fundamentals",
        "progress": 1.0,
        "status": "completed",
        "startDate": "Mar 1, 2024",
        "endDate": "Mar 30, 2024",
        "modules": [
          {"title": "Cloud Basics", "completed": true},
          {"title": "Deployment", "completed": true},
        ],
      },
    ];
  }
}
