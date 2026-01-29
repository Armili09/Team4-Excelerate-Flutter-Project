class User {
  final String name;
  final String bio;
  final String avatarUrl;
  final int completedCourses;
  final int certificates;
  final int badges;

  User({
    required this.name,
    required this.bio,
    required this.avatarUrl,
    required this.completedCourses,
    required this.certificates,
    required this.badges,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      bio: json['bio'],
      avatarUrl: json['avatarUrl'],
      completedCourses: json['completedCourses'],
      certificates: json['certificates'],
      badges: json['badges'],
    );
  }
}
