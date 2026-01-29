import 'package:flutter/material.dart';

class ProgramFilterSheet extends StatefulWidget {
  final String selectedCategory;
  final String selectedDifficulty;
  final String selectedDuration;
  final Function(String category, String difficulty, String duration) onApply;

  const ProgramFilterSheet({
    super.key,
    required this.selectedCategory,
    required this.selectedDifficulty,
    required this.selectedDuration,
    required this.onApply,
  });

  @override
  State<ProgramFilterSheet> createState() => _ProgramFilterSheetState();
}

class _ProgramFilterSheetState extends State<ProgramFilterSheet> {
  late String _category;
  late String _difficulty;
  late String _duration;

  final List<String> _categories = [
    'All',
    'Web Development',
    'Mobile Development',
    'Data Science',
    'Cloud Computing',
    'Design',
    'DevOps',
  ];

  final List<String> _difficulties = [
    'All',
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  final List<String> _durations = [
    'All',
    '< 8 weeks',
    '8-12 weeks',
    '12-16 weeks',
    '> 16 weeks',
  ];

  @override
  void initState() {
    super.initState();
    _category = widget.selectedCategory;
    _difficulty = widget.selectedDifficulty;
    _duration = widget.selectedDuration;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Programs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _category = 'All';
                    _difficulty = 'All';
                    _duration = 'All';
                  });
                },
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Category
          const Text(
            'Category',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((category) {
              final isSelected = _category == category;
              return ChoiceChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() => _category = category);
                },
                selectedColor: Colors.deepPurple[100],
                checkmarkColor: Colors.deepPurple,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.deepPurple : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          // Difficulty
          const Text(
            'Difficulty',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _difficulties.map((difficulty) {
              final isSelected = _difficulty == difficulty;
              return ChoiceChip(
                label: Text(difficulty),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() => _difficulty = difficulty);
                },
                selectedColor: Colors.deepPurple[100],
                checkmarkColor: Colors.deepPurple,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.deepPurple : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          // Duration
          const Text(
            'Duration',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _durations.map((duration) {
              final isSelected = _duration == duration;
              return ChoiceChip(
                label: Text(duration),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() => _duration = duration);
                },
                selectedColor: Colors.deepPurple[100],
                checkmarkColor: Colors.deepPurple,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.deepPurple : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          // Apply Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onApply(_category, _difficulty, _duration);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Apply Filters',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
