import 'package:flutter/material.dart';

class UserProfile extends ChangeNotifier {
  String avatarUrl;
  String name;
  String bio;

  // Personal Info
  String email;
  String education;

  // Skills & Interests
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

  void updateProfile({
    required String name,
    required String bio,
    required String avatarUrl,
    required String email,
    required String education,
    required List<String> skills,
    required List<String> interests,
  }) {
    this.name = name;
    this.bio = bio;
    this.avatarUrl = avatarUrl;
    this.email = email;
    this.education = education;
    this.skills = skills;
    this.interests = interests;

    notifyListeners();
  }
}
