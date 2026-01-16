// onboarding_screen.dart
// Screen that will help us introduces app features through a guided tour

// Package imports
import 'package:flutter/material.dart';
import 'package:learning_app/utils/intro_screens/intro_page_1.dart';
import 'package:learning_app/utils/intro_screens/intro_page_2.dart';
import 'package:learning_app/utils/intro_screens/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Onboarding screen widget
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

/// State class for managing onboarding screen interactions
class _OnboardingScreenState extends State<OnboardingScreen> {
  /// Controller for managing page view navigation
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              // Individual onboarding pages
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),

          // Page indicator positioned at bottom center
          Positioned(
            bottom: 60, // Height from bottom of screen
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3, // Matches number of pages
                effect: const WormEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.white54,
                  dotHeight: 12,
                  dotWidth: 12,
                  spacing: 8,
                  type: WormType.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
