import 'package:flutter/material.dart';
import '../utils/models/user_profile.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfile _userProfile;

  UserProfileProvider({required UserProfile initialProfile})
    : _userProfile = initialProfile;

  UserProfile get userProfile => _userProfile;

  void updateProfile(UserProfile newProfile) {
    _userProfile = newProfile;
    notifyListeners();
  }

  // You can add more specific update methods here if needed
  void updateBasicInfo({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? bio,
  }) {
    _userProfile = UserProfile(
      id: _userProfile.id,
      firstName: firstName ?? _userProfile.firstName,
      lastName: lastName ?? _userProfile.lastName,
      email: email ?? _userProfile.email,
      phoneNumber: phoneNumber ?? _userProfile.phoneNumber,
      bio: bio ?? _userProfile.bio,
      profileImageUrl: _userProfile.profileImageUrl,
      dateOfBirth: _userProfile.dateOfBirth,
      location: _userProfile.location,
      occupation: _userProfile.occupation,
      organization: _userProfile.organization,
      interests: _userProfile.interests,
      skills: _userProfile.skills,
      educationLevel: _userProfile.educationLevel,
      linkedInUrl: _userProfile.linkedInUrl,
      githubUrl: _userProfile.githubUrl,
      isPublicProfile: _userProfile.isPublicProfile,
      createdAt: _userProfile.createdAt,
      updatedAt: DateTime.now(),
    );
    notifyListeners();
  }

  // Add more specific update methods as needed
}
