import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:learning_app/features/dashboard/dashboard_page.dart';
import 'features/login/login_page.dart';
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
      create: (_) => UserProfile(/* ... */),
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

  void _completeOnboarding() => setState(() => _onboardingCompleted = true);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(/* ... */), // Keep theme config
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
