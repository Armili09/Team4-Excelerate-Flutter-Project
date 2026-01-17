import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/user_profile.dart';
import '../utils/profile_stat_card.dart';
import 'edit_profile_screen.dart';
import 'logout_screen.dart';
import 'placeholder_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LogoutScreen()),
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProfile>();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// ======================
          /// Profile Header
          /// ======================
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.bio,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfileStatCard(
                        label: "Courses",
                        value: user.completedCourses,
                      ),
                      ProfileStatCard(label: "Badges", value: user.badges),
                      ProfileStatCard(
                        label: "Certificates",
                        value: user.certificates,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// ======================
          /// Personal Information
          /// ======================
          _infoCard(
            title: "Personal Information",
            children: [
              _infoRow("Email", user.email),
              _infoRow("Education", user.education),
            ],
          ),

          const SizedBox(height: 16),

          /// ======================
          /// Skills
          /// ======================
          _chipCard(title: "Skills", items: user.skills),

          const SizedBox(height: 16),

          /// ======================
          /// Interests
          /// ======================
          _chipCard(title: "Interests", items: user.interests),

          const SizedBox(height: 24),

          /// ======================
          /// Navigation Actions
          /// ======================
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text("Edit Profile"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProfileScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),

                ListTile(
                  leading: const Icon(Icons.emoji_events),
                  title: const Text("Badges"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const PlaceholderScreen(title: "Badges"),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),

                ListTile(
                  leading: const Icon(Icons.card_membership),
                  title: const Text("Certificates"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const PlaceholderScreen(title: "Certificates"),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),

                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const PlaceholderScreen(title: "Settings"),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),

                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap: () => _confirmLogout(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ======================
  /// Helper Widgets
  /// ======================

  static Widget _infoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  static Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  static Widget _chipCard({
    required String title,
    required List<String> items,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items.map((item) => Chip(label: Text(item))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
