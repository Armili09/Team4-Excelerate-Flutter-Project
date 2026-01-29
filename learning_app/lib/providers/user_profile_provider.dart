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
    _userProfile = _userProfile.copyWith(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      bio: bio,
    );
    notifyListeners();
  }

  // Add more specific update methods as needed
}
