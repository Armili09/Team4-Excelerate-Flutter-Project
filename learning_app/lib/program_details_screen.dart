import 'package:flutter/material.dart';

// If you already have Program model elsewhere, remove this and import your model.
class Program {
  final String id;
  final String title;
  final String description;
  final String category;
  final String level;
  final int durationMins;
  final List<String> tags;

  const Program({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.level,
    required this.durationMins,
    required this.tags,
  });
}

class ProgramDetailsScreen extends StatefulWidget {
  final Program program;

  /// true = Guest (read-only)
  /// false = User (can enroll/bookmark/add note)
  final bool isGuest;

  /// optional: call this when user taps "Login" from guest mode
  final VoidCallback? onLoginTap;

  const ProgramDetailsScreen({
    super.key,
    required this.program,
    required this.isGuest,
    this.onLoginTap,
  });

  @override
  State<ProgramDetailsScreen> createState() => _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends State<ProgramDetailsScreen> {
  bool _enrolled = false;
  bool _bookmarked = false;
  final TextEditingController _noteCtrl = TextEditingController();

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.program;

    return Scaffold(
      appBar: AppBar(
        title: Text(p.title),
        actions: [
          // Show bookmark icon only for User mode
          if (!widget.isGuest)
            IconButton(
              tooltip: 'Bookmark',
              onPressed: () => setState(() => _bookmarked = !_bookmarked),
              icon: Icon(_bookmarked ? Icons.bookmark : Icons.bookmark_border),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(p.description, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 14),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(label: Text(p.category)),
              Chip(label: Text(p.level)),
              Chip(label: Text('${p.durationMins} min')),              ...p.tags.map((t) => Chip(label: Text(t))),
            ],
          ),

          const SizedBox(height: 22),

          // ===== Guest Mode =====
          if (widget.isGuest) ...[
            _infoCard(
              context,
              title: 'Guest Mode',
              message:
                  'You can view program information, but you must login to enroll, bookmark, or add notes.',
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: widget.onLoginTap ??
                  () {
                    // If you have a login route, replace this with Navigator.pushNamed(context, '/login')
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Navigate to Login (mock)')),
                    );
                  },
              icon: const Icon(Icons.login),
              label: const Text('Login to Enroll / Save'),
            ),
          ]

          // ===== User Mode =====
          else ...[
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: _enrolled
                        ? null
                        : () => setState(() => _enrolled = true),
                    child: Text(_enrolled ? 'Enrolled' : 'Enroll'),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Shared: ${p.title}')),
                    );
                  },
                  child: const Text('Share'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _noteCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Personal Note (User only)',
                hintText: 'What did you learn? Any reminders?',
                border: OutlineInputBorder(),
              ),
            ),

            
            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: () {
                // Mock "save"
                final note = _noteCtrl.text.trim();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      note.isEmpty ? 'Note cleared (mock)' : 'Note saved (mock)',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.save),
              label: const Text('Save Note'),
            ),

            const SizedBox(height: 18),

            _infoCard(
              context,
              title: 'Progress',
              message: _enrolled
                  ? 'You are enrolled. Next step: start the first module.'
                  : 'Not enrolled yet. Tap Enroll to track progress.',
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoCard(BuildContext context,
      {required String title, required String message}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(message),
          ],
        ),
      ),
    );
  }
}
