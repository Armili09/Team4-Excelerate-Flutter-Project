import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/models/user_profile.dart';
import '../providers/user_profile_provider.dart';
import '../providers/auth_provider.dart';
import '../services/data_service.dart';
import 'profile/edit_profile_screen.dart';
import 'profile/certificates_screen.dart';
import 'profile/badges_screen.dart';
import 'dashboard/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _loading = true;
  String? _error;

  // These will be loaded dynamically
  List<Map<String, String>> certificates = [];
  List<String> badges = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// Map old education strings to EducationLevel enum
  EducationLevel _mapEducationLevel(String? education) {
    if (education == null) return EducationLevel.other;

    switch (education.toLowerCase()) {
      case 'high school':
        return EducationLevel.highSchool;
      case 'associate':
      case 'associate degree':
        return EducationLevel.associate;
      case 'bachelor':
      case 'bs':
      case 'ba':
        return EducationLevel.bachelor;
      case 'master':
      case 'ms':
      case 'ma':
        return EducationLevel.master;
      case 'phd':
      case 'doctorate':
        return EducationLevel.doctorate;
      default:
        return EducationLevel.other;
    }
  }

  /// Fetch profile + courses
  Future<void> _loadData() async {
    try {
      final userJson = await DataService().fetchUserProfile();
      final coursesJson = await DataService().fetchMyCourses();

      if (!mounted) return;

      // Load user profile into provider - map old fields to new structure
      final mappedUserJson = {
        'id': userJson['id'] ?? 'user123',
        'firstName': (userJson['name'] as String?)?.split(' ').first ?? '',
        'lastName': (userJson['name'] as String?)?.split(' ').last ?? '',
        'email': userJson['email'] ?? '',
        'profileImageUrl': userJson['avatarUrl'] ?? '',
        'bio': userJson['bio'] ?? '',
        'educationLevel': _mapEducationLevel(userJson['education'] as String?),
        'skills': List<String>.from(userJson['skills'] ?? []),
        'interests': List<String>.from(userJson['interests'] ?? []),
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

      context.read<UserProfileProvider>().updateProfile(
        UserProfile.fromJson(mappedUserJson),
      );

      // Certificates from completed courses
      final completedCourses = coursesJson
          .where((c) => c['status'] == 'completed')
          .toList();
      certificates = completedCourses
          .map((c) => {'title': c['title'].toString(), 'date': 'Jan 2024'})
          .toList();

      // Example badges
      badges = ['7 Day Streak', 'Top Learner', 'Certified', 'Graduate'];

      setState(() => _loading = false);
    } catch (e) {
      setState(() {
        _error = 'Failed to load profile';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = context.watch<UserProfileProvider>();
    final user = userProfileProvider.userProfile;

    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Text(_error!, style: const TextStyle(color: Colors.red)),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            // Page Title
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Profile Header
            CircleAvatar(
              radius: 48,
              backgroundImage: user.profileImageUrl?.isNotEmpty == true
                  ? NetworkImage(user.profileImageUrl!)
                  : null,
              child: user.profileImageUrl?.isEmpty != false
                  ? const Icon(Icons.person, size: 48)
                  : null,
            ),
            const SizedBox(height: 12),

            Text(
              user.fullName.isNotEmpty ? user.fullName : '—',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              user.bio ?? '',
              style: TextStyle(color: Colors.grey.shade400),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Edit Profile Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(profile: user),
                  ),
                );
              },
              child: const Text('Edit Profile'),
            ),

            const SizedBox(height: 24),

            // Stats
            Row(
              children: [
                _statCard('0', 'Courses'),
                _statCard('${certificates.length}', 'Certificates'),
                _statCard('${badges.length}', 'Badges'),
              ],
            ),

            const SizedBox(height: 32),

            // Profile Details
            _section('Profile Details'),
            _infoRow('Email', user.email),
            _infoRow('Education', user.educationLevel?.toString() ?? '—'),
            _infoRow('Skills', user.skills.join(', ')),
            _infoRow('Interests', user.interests.join(', ')),

            const SizedBox(height: 32),

            // Certificates Section
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
                        builder: (_) => const CertificatesScreen(),
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

            // Badges Section
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
                      MaterialPageRoute(builder: (_) => const BadgesScreen()),
                    );
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(spacing: 12, children: badges.map(_badge).toList()),

            const SizedBox(height: 32),

            // Account Section
            _section('Account'),
            _accountTile(
              context,
              icon: Icons.settings,
              title: 'Settings',
              subtitle: '',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
            _accountTile(
              context,
              icon: Icons.logout,
              title: 'Logout',
              subtitle: '',
              bgColor: Colors.red.shade700,
              onTap: () async {
                // Clear user profile
                context.read<UserProfileProvider>().updateProfile(
                  UserProfile(
                    id: '',
                    firstName: '',
                    lastName: '',
                    email: '',
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                );

                // Sign out using AuthProvider
                await context.read<AuthProvider>().signOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ----------------- UI Helpers -----------------

  Widget _statCard(String value, String label) => Expanded(
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
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
    ),
  );

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
    child: ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
    ),
  );

  Widget _badge(String label) => Chip(
    backgroundColor: const Color(0xFF11283E),
    label: Text(label, style: const TextStyle(color: Colors.white)),
  );

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
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: const TextStyle(color: Colors.white70))
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.white70),
      onTap: onTap,
    ),
  );
}
