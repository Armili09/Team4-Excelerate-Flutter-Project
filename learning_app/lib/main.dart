import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'screens/programs_screen.dart';
import 'screens/my_courses_screen.dart';
import 'screens/profile_screen.dart';
import 'utils/user_profile.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProfile(
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
        name: 'John Doe',
        bio: 'Flutter Developer & Learning Enthusiast',
        email: 'john.doe@example.com',
        education: 'B.Sc. Computer Science',
        skills: ['Flutter', 'Dart', 'UI/UX'],
        interests: ['Mobile Apps', 'AI', 'Gaming'],
        completedCourses: 5,
        badges: 3,
        certificates: 2,
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor = Color(0xFF1C64F2);
  static const Color backgroundColor = Color(0xFF0C1C2B);
  static const Color cardColor = Color(0xFF11283E);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning App',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,

        // Global background
        scaffoldBackgroundColor: backgroundColor,

        // Color scheme
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          onPrimary: Colors.white,
          background: backgroundColor,
          surface: cardColor,
          onSurface: Colors.white,
          secondary: Color(0xFFFFE973),
        ),

        // Card styling (FIXED)
        cardTheme: const CardThemeData(
          color: cardColor,
          elevation: 3,
          shadowColor: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),

        // AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          centerTitle: true,
          elevation: 2,
        ),

        // Bottom navigation
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: backgroundColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.white60,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ProgramsScreen(),
    MyCoursesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Programs'),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Learning',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
