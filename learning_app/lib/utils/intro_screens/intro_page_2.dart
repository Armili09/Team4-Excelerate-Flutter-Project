import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// This is the second onboarding screen (Features screen).
/// I show the user the main value propositions of the app in a clean,
/// visual way so they understand why signing up is worth it.
class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    // Main container with white background — keeps the whole screen clean
    return Container(
      color: Colors.white,
      child: Padding(
        // Generous vertical padding so content doesn't touch screen edges
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header section with app name and "Features" subtitle
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 0.0),
              child: Column(
                children: [
                  // Big app name with shadow for a bit of depth
                  Text(
                    'Edu Portal',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black54,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  // Smaller subtitle to tell user what this screen is about
                  Text(
                    'Features',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Main content area takes most of the remaining space
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Top part: Lottie animation (search.json) — gives a lively feel
                  Expanded(
                    flex: 1,
                    child: Lottie.asset(
                      'assets/lottie/search.json',
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Bottom part: list of feature cards
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Feature card 1: Progress tracking
                        _buildFeatureCard(
                          icon: Icons.checklist,
                          title: 'Track Your Progress',
                          description:
                              "See exactly how far you've come in every course",
                        ),

                        // Feature card 2: Certificates
                        _buildFeatureCard(
                          icon: Icons.verified_user,
                          title: 'Earn Real Certificates',
                          description:
                              "Downloadable certificates you can share on LinkedIn & CV",
                        ),

                        // Feature card 3: Learn anywhere
                        _buildFeatureCard(
                          icon: Icons.rocket,
                          title: 'Learn Anywhere, Anytime',
                          description:
                              "Continue exactly where you left off — even offline downloads",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method that creates one consistent feature card.
  /// I extracted this so I don't repeat the same styling three times.
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      // Light semi-transparent gray background + rounded corners
      decoration: BoxDecoration(
        color: const Color.fromARGB(55, 79, 82, 83),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Small icon at the top of each card
          Icon(icon, color: const Color(0xFF0D47A1), size: 20),
          // Feature title in bold
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Short description below the title
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.bold, // kept bold like in original
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
