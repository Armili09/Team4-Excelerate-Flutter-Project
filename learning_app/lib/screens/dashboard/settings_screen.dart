import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../providers/settings_provider.dart';
import 'package:learning_app/utils/models/badge.dart' as custom_badge;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Mock data for earned badges
  final List<custom_badge.Badge> _earnedBadges = [
    custom_badge.Badge(
      id: '1',
      title: 'Quick Learner',
      description: 'Completed 5 courses in a week',
      iconUrl: 'assets/icons/badge1.png',
      category: 'Achievement',
      earnedDate: DateTime.now().subtract(const Duration(days: 2)),
      rarity: 'Rare',
      pointsEarned: 100,
    ),
    custom_badge.Badge(
      id: '2',
      title: 'Perfect Score',
      description: 'Scored 100% on a quiz',
      iconUrl: 'assets/icons/badge2.png',
      category: 'Excellence',
      earnedDate: DateTime.now().subtract(const Duration(days: 5)),
      rarity: 'Epic',
      pointsEarned: 200,
    ),
    custom_badge.Badge(
      id: '3',
      title: 'Early Bird',
      description: 'Completed a course within 24 hours of enrollment',
      iconUrl: 'assets/icons/badge3.png',
      category: 'Dedication',
      earnedDate: DateTime.now().subtract(const Duration(days: 10)),
      rarity: 'Legendary',
      pointsEarned: 300,
    ),
  ];

  // Show privacy policy dialog
  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const Text(
          'Our Privacy Policy describes how we collect, use, and share your personal data. '
          'We are committed to protecting your privacy and ensuring the security of your information.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              // In a real app, this would open your full privacy policy URL
              launchUrl(Uri.parse('https://example.com/privacy-policy'));
              Navigator.pop(context);
            },
            child: const Text('View Full Policy'),
          ),
        ],
      ),
    );
  }

  // Show account deletion confirmation
  void _confirmAccountDeletion() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // In a real app, this would delete the user's account
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deletion request received'),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badges Carousel Section
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Earned Badges',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: _earnedBadges.length,
                itemBuilder: (context, index) {
                  final badge = _earnedBadges[index];
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primaryContainer,
                          child: Icon(
                            Icons.emoji_events,
                            size: 30,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          badge.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(),

            // Preferences Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Preferences',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Consumer<SettingsProvider>(
              builder: (context, settings, _) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Dark Mode'),
                        value: settings.darkMode,
                        onChanged: (value) => settings.toggleDarkMode(value),
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        title: const Text('Enable Notifications'),
                        value: settings.notifications,
                        onChanged: (value) =>
                            settings.toggleNotifications(value),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        title: const Text('Language'),
                        trailing: DropdownButton<String>(
                          value: settings.language,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              settings.changeLanguage(newValue);
                            }
                          },
                          items:
                              <String>[
                                'English',
                                'Spanish',
                                'French',
                                'German',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Account Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Account',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _showPrivacyPolicy,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    title: const Text(
                      'Delete Account',
                      style: TextStyle(color: Colors.red),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.red,
                    ),
                    onTap: _confirmAccountDeletion,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
