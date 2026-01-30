// ignore_for_file: unnecessary_underscores

import 'package:flutter/material.dart';

class Program {
  final String id;
  final String title;
  final String category; // Cloud / Data / Frontend
  final String level;    // Beginner / Intermediate / Advanced
  final int durationMins;
  final List<String> tags;

  const Program({
    required this.id,
    required this.title,
    required this.category,
    required this.level,
    required this.durationMins,
    required this.tags,
  });
}

class ProgramListScreen extends StatefulWidget {
  const ProgramListScreen({super.key});

  @override
  State<ProgramListScreen> createState() => _ProgramListScreenState();
}

class _ProgramListScreenState extends State<ProgramListScreen> {
  // Mock data (replace later with API)
  final List<Program> _programs = const [
    Program(
      id: 'p1',
      title: 'AWS Serverless Foundations',
      category: 'Cloud',
      level: 'Beginner',
      durationMins: 180,
      tags: ['Lambda', 'EventBridge', 'API Gateway'],
    ),
    Program(
      id: 'p2',
      title: 'Flutter UI + Navigation',
      category: 'Frontend',
      level: 'Beginner',
      durationMins: 150,
      tags: ['Flutter', 'Dart', 'Provider'],
    ),
    Program(
      id: 'p3',
      title: 'Data Analysis Crash Course',
      category: 'Data',
      level: 'Intermediate',
      durationMins: 210,
      tags: ['SQL', 'Python', 'Charts'],
    ),
    Program(
      id: 'p4',
      title: 'Event-Driven Architecture on AWS',
      category: 'Cloud',
      level: 'Advanced',
      durationMins: 240,
      tags: ['EventBridge', 'SQS', 'SNS'],
    ),
  ];

  String _query = '';
  String? _category; // null = all
  String? _level;    // null = all

  List<Program> get _filtered {
    final q = _query.trim().toLowerCase();
    return _programs.where((p) {
      final matchesQuery = q.isEmpty ||
          p.title.toLowerCase().contains(q) ||
          p.tags.any((t) => t.toLowerCase().contains(q));

      final matchesCategory = _category == null || p.category == _category;
      final matchesLevel = _level == null || p.level == _level;

      return matchesQuery && matchesCategory && matchesLevel;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const categories = ['Cloud', 'Data', 'Frontend'];
    const levels = ['Beginner', 'Intermediate', 'Advanced'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Programs'),
        actions: [
          IconButton(
            tooltip: 'Clear filters',
            onPressed: () => setState(() {
              _query = '';
              _category = null;
              _level = null;
            }),
            icon: const Icon(Icons.clear_all),
          )
        ],
      ),
      body: Column(
        children: [
          // Search box
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(
                labelText: 'Search by title or tag',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Text('Category:  '),
                _choiceChip(
                  label: 'All',
                  selected: _category == null,
                  onTap: () => setState(() => _category = null),
                ),
                ...categories.map((c) => _choiceChip(
                      label: c,
                      selected: _category == c,
                      onTap: () => setState(() => _category = c),
                    )),
                const SizedBox(width: 16),
                const Text('Level:  '),
                _choiceChip(
                  label: 'All',
                  selected: _level == null,
                  onTap: () => setState(() => _level = null),
                ),
                ...levels.map((l) => _choiceChip(
                      label: l,
                      selected: _level == l,
                      onTap: () => setState(() => _level = l),
                    )),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Result list
          Expanded(
            child: _filtered.isEmpty
                ? const Center(child: Text('No programs found'))
                : ListView.separated(
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final p = _filtered[i];
                      return ListTile(
                        title: Text(p.title),
                        subtitle:
                            Text('${p.category} • ${p.level} • ${p.durationMins} min'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          // For now just show a quick preview
                          showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            builder: (_) => Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  const SizedBox(height: 8),
                                  Text('${p.category} • ${p.level} • ${p.durationMins} min'),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children:
                                        p.tags.map((t) => Chip(label: Text(t))).toList(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _choiceChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}
