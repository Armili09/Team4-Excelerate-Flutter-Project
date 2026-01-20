import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:learning_app/features/dashboard/dashboard_page.dart';
import 'features/login/login_page.dart';
import 'screens/onboarding_screen.dart';
import 'utils/user_profile.dart';

/// Combined main() with both orientation lock and state management
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProfile(
        avatarUrl: '',
        name: 'User',
        bio: 'Welcome to Excelerate',
        email: '',
        education: '',
        skills: [],
        interests: [],
        completedCourses: 0,
        badges: 0,
        certificates: 0,
      ),
      child: const MyApp(),
    ),
  );
}

/// Unified MyApp with state management and route configuration
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _onboardingCompleted = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF2B8CEE),
      ),
      home: _onboardingCompleted 
          ? const LoginPage() // Transition to login after onboarding
          : const OnboardingScreen(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/main': (context) => const MainNavigation(),
      },
    );
  }
}

/// Main Navigation widget for the app
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excelerate'),
        backgroundColor: const Color(0xFF2B8CEE),
      ),
      body: Center(
        child: Text('Navigation Page ${_selectedIndex + 1}'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
