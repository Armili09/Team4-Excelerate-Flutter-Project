import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // mock login state (replace later with AuthService)
    final bool isLoggedIn = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: isLoggedIn ? _loggedInView(context) : _guestView(context),
    );
  }

  // ---------------- LOGGED IN VIEW ----------------
  Widget _loggedInView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 40,
            child: Icon(Icons.person, size: 40),
          ),
          const SizedBox(height: 12),
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            'johndoe@email.com',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),

          _profileTile(
            icon: Icons.edit,
            title: 'Edit Profile',
            onTap: () {},
          ),
          _profileTile(
            icon: Icons.bookmark,
            title: 'My Courses',
            onTap: () {},
          ),
          _profileTile(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          _profileTile(
            icon: Icons.logout,
            title: 'Logout',
            color: Colors.red,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ---------------- GUEST VIEW ----------------
  Widget _guestView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock_outline, size: 48),
          const SizedBox(height: 12),
          const Text(
            'You are not logged in',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }

  // ---------------- REUSABLE TILE ----------------
  Widget _profileTile({
    required IconData icon,
    required String title,
    Color? color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
