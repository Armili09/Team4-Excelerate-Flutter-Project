import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_shell.dart';
import 'utils/user_profile.dart';
import 'data/mock_user_data.dart';

void main() {
  runApp(
    ChangeNotifierProvider<UserProfile>(
      create: (_) => createMockUserProfile(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomeShell(),
    );
  }
}
