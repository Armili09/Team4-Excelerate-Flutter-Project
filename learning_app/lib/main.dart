/// Main entry point for the Learning App
/// 
/// Initializes the application with:
/// - Provider state management for user profile
/// - Dark theme configuration
/// - Onboarding/main navigation flow
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

/// Root application widget managing:
/// - Theme configuration
/// - Onboarding completion state
/// - Navigation flow control
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

/// State management for application-level features
class _MyAppState extends State<MyApp> {
  /// Tracks whether user has completed onboarding
  /// 
  /// Defaults to `false` (show onboarding first)
  bool _onboardingCompleted = false;

  /// Callback to mark onboarding as completed
  /// 
  /// Triggers navigation to main app interface
  void _completeOnboarding() {
    setState(() {
      _onboardingCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Theme color constants
    const primaryColor = Color(0xFF1C64F2);
    const backgroundColor = Color(0xFF1F2A44);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning App',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.dark(
          primary: primaryColor,
          onPrimary: Colors.white,
          background: backgroundColor,
          surface: const Color(0xFF2A3A60),
          onSurface: Colors.white,
          secondary: Colors.yellow.shade700,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F2A44),
          centerTitle: true,
          elevation: 2,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1F2A44),
          selectedItemColor: Color(0xFF1C64F2),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      /// Determines initial screen based on onboarding state
      /// 
      /// - Shows [OnboardingScreen] if not completed
      /// - Navigates to [MainNavigation] when completed
      home: _onboardingCompleted
          ? const MainNavigation()
          : OnboardingScreen(onComplete: _completeOnboarding),
    );
  }
}

/// Primary navigation structure with bottom bar
/// 
/// Contains four main screens:
/// 1. Home
/// 2. Programs
/// 3. My Courses
/// 4. Profile
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

/// Manages navigation state between app sections
