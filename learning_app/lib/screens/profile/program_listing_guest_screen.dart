import 'package:flutter/material.dart';
import '../../utils/models/program.dart';
import '../../utils/program_card.dart';

class ProgramListingGuestScreen extends StatefulWidget {
  const ProgramListingGuestScreen({super.key});

  @override
  State<ProgramListingGuestScreen> createState() =>
      _ProgramListingGuestScreenState();
}

class _ProgramListingGuestScreenState extends State<ProgramListingGuestScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _selectedDifficulty = 'All';
  String _sortBy = 'Popular';

  final List<String> _categories = [
    'All',
    'Technology',
    'Business',
    'Design',
    'Marketing',
    'Data Science',
    'Development',
  ];

  final List<String> _difficulties = [
    'All',
    'Beginner',
    'Intermediate',
    'Advanced',
  ];
  final List<String> _sortOptions = ['Popular', 'Newest', 'Rating', 'Duration'];

  // Mock data - Replace with actual API call
  final List<Program> _allPrograms = [
    Program(
      id: '1',
      title: 'Full Stack Web Development',
      description:
          'Master both frontend and backend development with modern technologies',
      category: 'Development',
      difficulty: 'Intermediate',
      durationInWeeks: 24,
      imageUrl: 'https://via.placeholder.com/400x200',
      skills: ['React', 'Node.js', 'MongoDB', 'Express'],
      enrolledCount: 1250,
      rating: 4.8,
      requiresApplication: true,
      courses: [],
    ),
    Program(
      id: '2',
      title: 'Data Science Fundamentals',
      description:
          'Learn data analysis, visualization, and machine learning basics',
      category: 'Data Science',
      difficulty: 'Beginner',
      durationInWeeks: 16,
      imageUrl: 'https://via.placeholder.com/400x200',
      skills: ['Python', 'Pandas', 'NumPy', 'Scikit-learn'],
      enrolledCount: 2100,
      rating: 4.9,
      requiresApplication: false,
      courses: [],
    ),
    Program(
      id: '3',
      title: 'UX/UI Design Masterclass',
      description:
          'Create beautiful and user-friendly interfaces with industry-standard tools',
      category: 'Design',
      difficulty: 'Intermediate',
      durationInWeeks: 12,
      imageUrl: 'https://via.placeholder.com/400x200',
      skills: ['Figma', 'Adobe XD', 'User Research', 'Prototyping'],
      enrolledCount: 980,
      rating: 4.7,
      requiresApplication: false,
      courses: [],
    ),
    Program(
      id: '4',
      title: 'Digital Marketing Strategy',
      description:
          'Build comprehensive marketing campaigns across all digital channels',
      category: 'Marketing',
      difficulty: 'Beginner',
      durationInWeeks: 8,
      imageUrl: 'https://via.placeholder.com/400x200',
      skills: ['SEO', 'Social Media', 'Analytics', 'Content Marketing'],
      enrolledCount: 1500,
      rating: 4.6,
      requiresApplication: false,
      courses: [],
    ),
    Program(
      id: '5',
      title: 'Cloud Architecture & DevOps',
      description: 'Design scalable cloud solutions and automate deployments',
      category: 'Technology',
      difficulty: 'Advanced',
      durationInWeeks: 20,
      imageUrl: 'https://via.placeholder.com/400x200',
      skills: ['AWS', 'Docker', 'Kubernetes', 'CI/CD'],
      enrolledCount: 750,
      rating: 4.9,
      requiresApplication: true,
      courses: [],
    ),
  ];

  List<Program> get _filteredPrograms {
    var programs = _allPrograms;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      programs = programs.where((p) {
        return p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p.skills.any(
              (s) => s.toLowerCase().contains(_searchQuery.toLowerCase()),
            );
      }).toList();
    }

    // Filter by category
    if (_selectedCategory != 'All') {
      programs = programs
          .where((p) => p.category == _selectedCategory)
          .toList();
    }

    // Filter by difficulty
    if (_selectedDifficulty != 'All') {
      programs = programs
          .where((p) => p.difficulty == _selectedDifficulty)
          .toList();
    }

    // Sort programs
    switch (_sortBy) {
      case 'Popular':
        programs.sort((a, b) => b.enrolledCount.compareTo(a.enrolledCount));
        break;
      case 'Rating':
        programs.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Duration':
        programs.sort((a, b) => a.durationInWeeks.compareTo(b.durationInWeeks));
        break;
      case 'Newest':
        // Would sort by creation date if available
        break;
    }

    return programs;
  }

  @override
  Widget build(BuildContext context) {
    final filteredPrograms = _filteredPrograms;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Browse Programs',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.login, color: Colors.blue),
            onPressed: () {
              _showLoginPrompt(context);
            },
            tooltip: 'Sign In',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search programs, skills...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(
                        'Category',
                        _selectedCategory,
                        _categories,
                        (value) => setState(() => _selectedCategory = value),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        'Difficulty',
                        _selectedDifficulty,
                        _difficulties,
                        (value) => setState(() => _selectedDifficulty = value),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        'Sort',
                        _sortBy,
                        _sortOptions,
                        (value) => setState(() => _sortBy = value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Results count
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredPrograms.length} ${filteredPrograms.length == 1 ? 'Program' : 'Programs'}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                if (_searchQuery.isNotEmpty ||
                    _selectedCategory != 'All' ||
                    _selectedDifficulty != 'All')
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                        _selectedCategory = 'All';
                        _selectedDifficulty = 'All';
                      });
                    },
                    icon: const Icon(Icons.clear, size: 18),
                    label: const Text('Clear Filters'),
                  ),
              ],
            ),
          ),
          // Programs List
          Expanded(
            child: filteredPrograms.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredPrograms.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ProgramCard(
                          program: filteredPrograms[index],
                          onTap: () => _showProgramDetails(
                            context,
                            filteredPrograms[index],
                          ),
                          showGuestPrompt: true,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    String currentValue,
    List<String> options,
    Function(String) onSelected,
  ) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (context) {
        return options.map((option) {
          return PopupMenuItem<String>(
            value: option,
            child: Row(
              children: [
                if (option == currentValue)
                  const Icon(Icons.check, size: 18, color: Colors.blue),
                if (option == currentValue) const SizedBox(width: 8),
                Text(option),
              ],
            ),
          );
        }).toList();
      },
      child: Chip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$label: $currentValue', style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down, size: 18),
          ],
        ),
        backgroundColor: Colors.blue[50],
        labelStyle: const TextStyle(color: Colors.blue),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No programs found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  void _showProgramDetails(BuildContext context, Program program) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    program.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildInfoChip(
                        Icons.signal_cellular_alt,
                        program.difficulty,
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        Icons.schedule,
                        '${program.durationInWeeks} weeks',
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(Icons.people, '${program.enrolledCount}+'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${program.rating}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'About',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    program.description,
                    style: TextStyle(color: Colors.grey[700], height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Skills You\'ll Learn',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: program.skills.map((skill) {
                      return Chip(
                        label: Text(skill),
                        backgroundColor: Colors.blue[50],
                        labelStyle: const TextStyle(color: Colors.blue),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showLoginPrompt(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        program.requiresApplication
                            ? 'Sign In to Apply'
                            : 'Sign In to Enroll',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        ],
      ),
    );
  }

  void _showLoginPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Sign In Required'),
        content: const Text(
          'Please sign in to enroll in programs, track your progress, and earn certificates.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to login screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navigate to login screen')),
              );
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
