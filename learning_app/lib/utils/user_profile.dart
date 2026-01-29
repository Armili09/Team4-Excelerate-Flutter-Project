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

  List<Map<String, String>> certificateList;
  List<String> badgeList;

  /// Constructor with optional defaults for safe initialization
  UserProfile({
    this.avatarUrl = '',
    this.name = '',
    this.bio = '',
    this.email = '',
    this.education = '',
    this.skills = const [],
    this.interests = const [],
    this.completedCourses = 0,
    this.badges = 0,
    this.certificates = 0,
    this.certificateList = const [],
    this.badgeList = const [],
  });

  /// Update profile from EditProfileScreen
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

  /// Load profile dynamically from JSON
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

  /// Clear all data on logout
  void clear() {
    avatarUrl = '';
    name = '';
    bio = '';
    email = '';
    education = '';
    skills = [];
    interests = [];
    completedCourses = 0;
    badges = 0;
    certificates = 0;
    certificateList = [];
    badgeList = [];
    notifyListeners();
  }
}
