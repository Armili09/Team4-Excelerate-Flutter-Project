import 'package:flutter/material.dart';
import 'package:learning_app/pages/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          OnboardingScreen(), // This is the onboarding screen that appears first
    );
  }
}
