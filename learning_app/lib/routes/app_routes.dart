import 'package:flutter/material.dart';
import '../screens/dashboard/home_screen.dart';
import '../screens/dashboard/profile_screen.dart';
import '../screens/dashboard/settings_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/home': (context) => const HomeScreen(),
    '/profile': (context) => const ProfileScreen(),
    '/settings': (context) => const SettingsScreen(),
  };
}
