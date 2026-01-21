import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:learning_app/features/dashboard/dashboard_page.dart';
import 'features/login/login_page.dart';
import '/utils/models/user_profile.dart';
import 'screens/profile/certificates_screen.dart';
import 'screens/profile/edit_profile_screen.dart';
import 'screens/profile/badges_screen.dart';
import 'screens/profile/program_listing_guest_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProfile(
        id: 'demo_user_1',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phoneNumber: '+1234567890',
        bio: 'Passionate learner exploring technology and data science',
        location: 'San Francisco, CA',
        occupation: 'Software Developer',
        organization: 'Tech Company Inc.',
        interests: ['Technology', 'Data Science', 'AI & Machine Learning'],
        skills: ['JavaScript', 'Python', 'React', 'Flutter'],
        educationLevel: EducationLevel.bachelor,
        linkedInUrl: 'https://linkedin.com/in/johndoe',
        githubUrl: 'https://github.com/johndoe',
        isPublicProfile: true,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime.now(),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _onboardingCompleted = false;

  void _completeOnboarding() => setState(() => _onboardingCompleted = true);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
        fontFamily: 'Inter',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: _onboardingCompleted 
          ? const LoginPage() // Transition to login after onboarding
          : OnboardingScreen(onComplete: _completeOnboarding),
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/main': (context) => const MainNavigation(),
      },
    );
  }
}

// Keep existing MainNavigation class from main branch
