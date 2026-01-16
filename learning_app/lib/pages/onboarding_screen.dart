// onboarding_screen.dart
// Screen that will help us introduces app features through a guided tour

// Package imports
import 'package:flutter/material.dart';
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
              _buildPage(Colors.amber, "Welcome"), // Welcome
              _buildPage(Colors.blue, "Features"), // Features
              _buildPage(Colors.green, "Get Started"), // Final CTA screen
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

  /// Helper method for creating consistent page layouts
  Widget _buildPage(Color color, String text) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
