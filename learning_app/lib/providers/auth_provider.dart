import 'package:flutter/material.dart';
import '../services/auth_storage.dart';
import '../utils/models/user_profile.dart';

class AuthProvider extends ChangeNotifier {
  UserProfile? _user;
  bool _isLoading = false;
  String? _error;

  UserProfile? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Initialize auth state and check for existing session
  Future<void> initialize() async {
    _setLoading(true);
    try {
      final user = await AuthStorage.loadUserSession();
      if (user != null) {
        _user = user;
      }
    } catch (e) {
      _setError('Failed to initialize authentication: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Sign up a new user
  Future<bool> signUp(String name, String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      // Load existing users
      final users = await AuthStorage.loadRegisteredUsers();
      
      // Check if email already exists
      if (users.any((u) => u.email == email)) {
        _setError('Email already registered');
        return false;
      }

      // Create new user
      final newUser = MockUser(
        name: name,
        email: email,
        password: password, // Note: In production, hash this password
      );

      // Save user to storage
      users.add(newUser);
      await AuthStorage.saveRegisteredUsers(users);

      // Create UserProfile for session
      final userProfile = UserProfile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        firstName: name.split(' ').first,
        lastName: name.split(' ').last,
        email: email,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save session
      await AuthStorage.saveUserSession(userProfile);
      _user = userProfile;

      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to sign up: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Sign in existing user
  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      // Load users from storage
      final users = await AuthStorage.loadRegisteredUsers();
      
      // Find user by email and password
      final user = users.firstWhere(
        (u) => u.email == email && u.password == password,
        orElse: () => MockUser(name: '', email: '', password: ''),
      );

      if (user.email.isEmpty) {
        _setError('Invalid email or password');
        return false;
      }

      // Create UserProfile for session
      final userProfile = UserProfile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        firstName: user.name.split(' ').first,
        lastName: user.name.split(' ').last,
        email: user.email,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save session
      await AuthStorage.saveUserSession(userProfile);
      _user = userProfile;

      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to sign in: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    _setLoading(true);
    try {
      await AuthStorage.clearUserSession();
      _user = null;
      notifyListeners();
    } catch (e) {
      _setError('Failed to sign out: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}
