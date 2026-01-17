import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/user_profile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController bioCtrl;
  late TextEditingController avatarCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController educationCtrl;
  late TextEditingController skillsCtrl;
  late TextEditingController interestsCtrl;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserProfile>();

    nameCtrl = TextEditingController(text: user.name);
    bioCtrl = TextEditingController(text: user.bio);
    avatarCtrl = TextEditingController(text: user.avatarUrl);
    emailCtrl = TextEditingController(text: user.email);
    educationCtrl = TextEditingController(text: user.education);
    skillsCtrl = TextEditingController(text: user.skills.join(", "));
    interestsCtrl = TextEditingController(text: user.interests.join(", "));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProfile>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          TextButton(
            onPressed: () {
              user.updateProfile(
                name: nameCtrl.text,
                bio: bioCtrl.text,
                avatarUrl: avatarCtrl.text,
                email: emailCtrl.text,
                education: educationCtrl.text,
                skills: skillsCtrl.text
                    .split(",")
                    .map((e) => e.trim())
                    .toList(),
                interests: interestsCtrl.text
                    .split(",")
                    .map((e) => e.trim())
                    .toList(),
              );

              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: avatarCtrl,
            decoration: const InputDecoration(labelText: "Avatar URL"),
          ),
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: bioCtrl,
            decoration: const InputDecoration(labelText: "Bio"),
            maxLines: 3,
          ),
          TextField(
            controller: emailCtrl,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: educationCtrl,
            decoration: const InputDecoration(labelText: "Education"),
          ),
          TextField(
            controller: skillsCtrl,
            decoration: const InputDecoration(
              labelText: "Skills (comma-separated)",
            ),
          ),
          TextField(
            controller: interestsCtrl,
            decoration: const InputDecoration(
              labelText: "Interests (comma-separated)",
            ),
          ),
        ],
      ),
    );
  }
}
