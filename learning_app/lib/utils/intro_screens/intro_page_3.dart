import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// This is the third and final onboarding screen (Get Started screen).
/// I use this page to remind the user of the main benefits of creating an account
/// and gently push them toward signing up before they enter the app.
class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    // Main container with white background to keep everything clean and bright
    return Container(
      color: Colors.white,
      child: Padding(
        // Big vertical padding so nothing feels cramped near the edges
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header section — same app name style as previous screens for consistency
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 0.0),
              child: Column(
                children: [
                  // Large app name with a soft shadow to give it some lift
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
                  // Subtitle that clearly tells the user what this screen is about
                  Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Big centered Lottie animation — I chose developer.json to feel aspirational
            // and show someone building/achieving something
            Expanded(
              child: Lottie.asset(
                'assets/lottie/developer.json',
                fit: BoxFit.contain,
              ),
            ),

            // Bottom section with benefits list and sign-up encouragement
            Padding(
              padding: const EdgeInsets.only(
                bottom: 60,
                left: 24,
                right: 24,
                top: 0,
              ),
              child: Column(
                children: [
                  // Headline that directly calls out the value of signing up
                  const Text(
                    'Sign up in seconds and unlock:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // List of key benefits — I made a small helper method to keep this clean
                  _buildListItem('Save all your progress forever'),
                  _buildListItem('Earn & download certificates'),
                  _buildListItem('Get personalized course suggestions'),
                  _buildListItem('Never lose your badges & achievements'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Small helper widget that creates one bullet point line.
  /// I extracted this so I can easily change the bullet style or spacing later
  /// without touching the main column.
  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 40, right: 0),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simple bullet character — I used a bigger font size so it stands out
            const Text(
              '• ',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Expanded(
              // The actual benefit text — expanded so it wraps nicely on narrow screens
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  height:
                      1.4, // a bit more line spacing makes it easier to read
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
