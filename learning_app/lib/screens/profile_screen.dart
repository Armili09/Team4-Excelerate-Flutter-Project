import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/user_profile.dart';
import 'edit_profile_screen.dart';
import 'placeholder_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProfile>();

    /// SAMPLE DATA (can later come from JSON)
    final List<Map<String, String>> certificates = [
      {'title': 'Flutter Development', 'date': 'Jan 2024'},
      {'title': 'Cloud Architecture', 'date': 'Oct 2023'},
      {'title': 'UI/UX Fundamentals', 'date': 'Aug 2023'},
    ];

    final List<String> badges = [
      '7 Day Streak',
      'Top Learner',
      'Certified',
      'Graduate',
    ];

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            /// PAGE TITLE
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            /// PROFILE HEADER
            CircleAvatar(
              radius: 48,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            const SizedBox(height: 12),

            Text(
              user.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              user.bio,
              style: TextStyle(color: Colors.grey.shade400),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            /// EDIT PROFILE
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );
              },
              child: const Text('Edit Profile'),
            ),

            const SizedBox(height: 24),

            /// STATS
            Row(
              children: [
                _statCard('${user.completedCourses}', 'Courses'),
                _statCard('${certificates.length}', 'Certificates'),
                _statCard('${badges.length}', 'Badges'),
              ],
            ),

            const SizedBox(height: 32),

            /// PROFILE DETAILS (UPDATED FROM EDIT PROFILE)
            _section('Profile Details'),
            _infoRow('Email', user.email),
            _infoRow('Education', user.education),
            _infoRow('Skills', user.skills.join(', ')),
            _infoRow('Interests', user.interests.join(', ')),

            const SizedBox(height: 32),

            /// CERTIFICATES SECTION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Earned Certificates',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const PlaceholderScreen(title: 'Certificates'),
                      ),
                    );
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Column(
              children: certificates
                  .take(2)
                  .map(
                    (cert) => _infoCard(context, cert['title']!, cert['date']!),
                  )
                  .toList(),
            ),

            const SizedBox(height: 32),

            /// BADGES SECTION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Badges',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const PlaceholderScreen(title: 'Badges'),
                      ),
                    );
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Wrap(spacing: 12, children: badges.map(_badge).toList()),

            const SizedBox(height: 32),

            /// ACCOUNT SECTION
            _section('Account'),
            _accountTile(
              context,
              icon: Icons.settings,
              title: 'Settings',
              subtitle: '',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PlaceholderScreen(title: 'Settings'),
                  ),
                );
              },
            ),
            _accountTile(
              context,
              icon: Icons.logout,
              title: 'Logout',
              subtitle: '',
              bgColor: Colors.red.shade700,
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------- UI HELPERS ----------

  Widget _statCard(String value, String label) {
    return Expanded(
      child: Card(
        color: const Color(0xFF11283E),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String title) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );

  Widget _infoRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            value.isNotEmpty ? value : '—',
            style: TextStyle(color: Colors.grey.shade300),
          ),
        ),
      ],
    ),
  );

  Widget _infoCard(BuildContext context, String title, String subtitle) => Card(
    color: const Color(0xFF11283E),
    child: ListTile(title: Text(title), subtitle: Text(subtitle), onTap: () {}),
  );

  Widget _badge(String label) =>
      Chip(backgroundColor: const Color(0xFF11283E), label: Text(label));

  Widget _accountTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Color? bgColor,
    required VoidCallback onTap,
  }) => Card(
    color: bgColor ?? const Color(0xFF11283E),
    child: ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    ),
  );

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const PlaceholderScreen(title: 'Logged Out'),
                ),
              );
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
