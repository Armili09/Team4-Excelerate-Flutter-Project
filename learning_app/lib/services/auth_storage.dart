import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/models/user_profile.dart';

class AuthStorage {
  static const String _userEmailKey = 'user_email';
  static const String _userNameKey = 'user_name';
  static const String _userIdKey = 'user_id';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _registeredUsersKey = 'registered_users';

  /// Save user session for auto-login
  static Future<void> saveUserSession(UserProfile user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userEmailKey, user.email);
    await prefs.setString(_userNameKey, user.fullName);
    await prefs.setString(_userIdKey, user.id);
    await prefs.setBool(_isLoggedInKey, true);
  }

  /// Load saved user session
  static Future<UserProfile?> loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_isLoggedInKey) == true) {
      return UserProfile(
        id: prefs.getString(_userIdKey) ?? '',
        firstName: prefs.getString(_userNameKey)?.split(' ').first ?? '',
        lastName: prefs.getString(_userNameKey)?.split(' ').last ?? '',
        email: prefs.getString(_userEmailKey) ?? '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
    return null;
  }

  /// Clear user session (logout)
  static Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_userIdKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  /// Save registered users to persistent storage
  static Future<void> saveRegisteredUsers(List<MockUser> users) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = users.map((user) => jsonEncode({
      'name': user.name,
      'email': user.email,
      'password': user.password, // Note: In production, hash passwords
    })).toList();
    await prefs.setStringList(_registeredUsersKey, usersJson);
  }

  /// Load registered users from persistent storage
  static Future<List<MockUser>> loadRegisteredUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList(_registeredUsersKey) ?? [];
    
    return usersJson.map((json) {
      final Map<String, dynamic> userMap = jsonDecode(json);
      return MockUser(
        name: userMap['name'],
        email: userMap['email'],
        password: userMap['password'],
      );
    }).toList();
  }
}

class MockUser {
  final String name;
  final String email;
  final String password;

  MockUser({required this.name, required this.email, required this.password});
}
