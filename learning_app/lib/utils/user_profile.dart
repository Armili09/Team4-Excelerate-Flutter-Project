import 'package:flutter/material.dart';

class UserProfile extends ChangeNotifier {
  String avatarUrl;
  String name;
  String bio;
  String email;
  String education;
  List<String> skills;
  List<String> interests;
  int completedCourses;
  int badges;
  int certificates;

  UserProfile({
    required this.avatarUrl,
    required this.name,
    required this.bio,
    required this.email,
    required this.education,
    required this.skills,
    required this.interests,
    required this.completedCourses,
    required this.badges,
    required this.certificates,
  });

  // Update user profile fields
  void updateProfile({
    String? avatarUrl,
    String? name,
    String? bio,
    String? email,
    String? education,
    List<String>? skills,
    List<String>? interests,
  }) {
    if (avatarUrl != null) this.avatarUrl = avatarUrl;
    if (name != null) this.name = name;
    if (bio != null) this.bio = bio;
    if (email != null) this.email = email;
    if (education != null) this.education = education;
    if (skills != null) this.skills = skills;
    if (interests != null) this.interests = interests;

    notifyListeners();
  }
}
