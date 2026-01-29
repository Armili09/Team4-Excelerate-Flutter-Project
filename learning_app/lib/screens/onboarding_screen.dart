// onboarding_screen.dart
// Screen that will help us introduces app features through a guided tour

// Package imports
import 'package:flutter/material.dart';
import 'package:learning_app/utils/intro_screens/intro_page_1.dart';
import 'package:learning_app/utils/intro_screens/intro_page_2.dart';
import 'package:learning_app/utils/intro_screens/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:learning_app/main.dart';

/// Onboarding screen widget
class OnboardingScreen extends StatefulWidget {
  final VoidCallback? onComplete;

  const OnboardingScreen({super.key, this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

/// State class for managing onboarding screen interactions
class _OnboardingScreenState extends State<OnboardingScreen> {
  /// Controller for managing page view navigation
  final PageController _controller = PageController();

  /// boolean to keep track of if we are on the last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (!onLastPage) ...[
                    // what will appear on all the onboarding screens apart from the last one
                    // skip
                    GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(2);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100, // Background color
                          borderRadius: BorderRadius.circular(
                            20,
                          ), // Rounded corners
                        ),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0D47A1),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),

                    // dot indicator
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3, // Matches number of pages
                      effect: const WormEffect(
                        activeDotColor: Color(0xFF0D47A1),
                        dotColor: Color.fromRGBO(91, 91, 91, 0.685),
                        dotHeight: 12,
                        dotWidth: 12,
                        spacing: 8,
                        type: WormType.normal,
                      ),
                    ),

                    // next button
                    GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100, // Background color
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0D47A1),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    /// what will appear on the last onboarding screen
                    ElevatedButton(
                      onPressed: () {
                        if (widget.onComplete != null) {
                          widget.onComplete!();
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainNavigation(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade100,
                        foregroundColor: Colors.blue.shade700,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
