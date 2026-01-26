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

  /// NEW: list of certificate titles/dates
  List<Map<String, String>> certificateList;
  List<String> badgeList;

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
    this.certificateList = const [],
    this.badgeList = const [],
  });

  /// Update user profile fields
  void updateProfile({
    String? avatarUrl,
    String? name,
    String? bio,
    String? email,
    String? education,
    List<String>? skills,
    List<String>? interests,
    List<Map<String, String>>? certificates,
    List<String>? badges,
  }) {
    if (avatarUrl != null) this.avatarUrl = avatarUrl;
    if (name != null) this.name = name;
    if (bio != null) this.bio = bio;
    if (email != null) this.email = email;
    if (education != null) this.education = education;
    if (skills != null) this.skills = skills;
    if (interests != null) this.interests = interests;
    if (certificates != null) this.certificateList = certificates;
    if (badges != null) this.badgeList = badges;

    notifyListeners();
  }

  /// Load from JSON (for your fetching)
  void loadFromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatarUrl'] ?? avatarUrl;
    name = json['name'] ?? name;
    bio = json['bio'] ?? bio;
    email = json['email'] ?? email;
    education = json['education'] ?? education;
    skills = List<String>.from(json['skills'] ?? skills);
    interests = List<String>.from(json['interests'] ?? interests);
    completedCourses = json['completedCourses'] ?? completedCourses;
    badges = json['badges'] ?? badges;
    certificates = json['certificates'] ?? certificates;
    certificateList = List<Map<String, String>>.from(
      json['certificateList'] ?? certificateList,
    );
    badgeList = List<String>.from(json['badgeList'] ?? badgeList);

    notifyListeners();
  }
}
