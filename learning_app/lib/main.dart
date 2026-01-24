import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/onboarding_screen.dart';
import 'providers/user_profile_provider.dart';
import 'providers/settings_provider.dart';
import 'utils/models/user_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize SharedPreferences
  await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProfileProvider(
            initialProfile: UserProfile(
              id: 'demo_user_1',
              firstName: 'John',
              lastName: 'Doe',
              email: 'john.doe@example.com',
              phoneNumber: '+1234567890',
              bio: 'Passionate learner exploring technology and data science',
              location: 'San Francisco, CA',
              occupation: 'Software Developer',
              organization: 'Tech Company Inc.',
              interests: [
                'Technology',
                'Data Science',
                'AI & Machine Learning',
              ],
              skills: ['JavaScript', 'Python', 'React', 'Flutter'],
              educationLevel: EducationLevel.bachelor,
              linkedInUrl: 'https://linkedin.com/in/johndoe',
              githubUrl: 'https://github.com/johndoe',
              isPublicProfile: true,
              createdAt: DateTime(2024, 1, 1),
              updatedAt: DateTime.now(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider()..loadSettings(),
        ),
      ],
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    // In a real app, you would check shared preferences or similar
    await Future.delayed(const Duration(seconds: 1)); // Simulate loading
    if (mounted) {
      setState(() {
        _onboardingCompleted = true; // Set to false to show onboarding first
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return MaterialApp(
          title: 'Excelerate Learning',
          debugShowCheckedModeBanner: false,
          themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
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
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.grey[900],
            fontFamily: 'Inter',
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              centerTitle: false,
              backgroundColor: Color(0xFF121212),
              foregroundColor: Colors.white,
            ),
            cardColor: const Color(0xFF1E1E1E),
            dividerColor: Colors.white24,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ),
          home: _onboardingCompleted
              ? const DashboardScreen()
              : const OnboardingScreen(),
        );
      },
    );
  }
}

// Main navigation is now handled by DashboardScreen
