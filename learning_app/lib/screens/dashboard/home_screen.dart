import 'package:flutter/material.dart';
import '../../utils/auth_service.dart';

/// ---------------- MOCK DATA ----------------

final List<Map<String, dynamic>> mockPrograms = [
  {'title': 'Flutter Basics', 'level': 'Beginner', 'duration': '4 Weeks'},
  {'title': 'Advanced Dart', 'level': 'Intermediate', 'duration': '3 Weeks'},
  {'title': 'State Management', 'level': 'Advanced', 'duration': '2 Weeks'},
];

final Map<String, int> mockStats = {
  'Programs': 12,
  'Enrolled': 4,
  'Completed': 1,
};

/// ---------------- UI ----------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = AuthService.isLoggedIn;

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Text(
              isLoggedIn ? 'Welcome back' : 'Welcome Guest',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            if (!isLoggedIn)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Sign up to get personalized recommendations',
                  style: TextStyle(color: Colors.grey),
                ),
              ),

            const SizedBox(height: 16),

            // Stats Cards
            Row(
              children: mockStats.entries.map((entry) {
                return Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(
                            entry.value.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(entry.key),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Programs List
            Expanded(
              child: ListView.builder(
                itemCount: mockPrograms.length,
                itemBuilder: (context, index) {
                  final program = mockPrograms[index];

                  return Card(
                    child: ListTile(
                      title: Text(program['title']),
                      subtitle: Text(
                        '${program['level']} • ${program['duration']}',
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
