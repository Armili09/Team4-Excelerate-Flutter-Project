import '../utils/user_profile.dart';

UserProfile createMockUserProfile() {
  return UserProfile(
    avatarUrl: "https://i.pravatar.cc/300",
    name: "Armili Paturi",
    bio: "Lifelong learner | Flutter & Mobile Dev",
    email: "armili@example.com",
    education: "B.S. Computer Science",
    skills: ["Flutter", "Dart", "UI Design"],
    interests: ["Mobile Apps", "AI", "Design"],
    completedCourses: 12,
    badges: 5,
    certificates: 3,
  );
}
