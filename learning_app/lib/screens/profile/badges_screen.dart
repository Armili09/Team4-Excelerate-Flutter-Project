import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/models/badge.dart' as custom_badge;

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({Key? key}) : super(key: key);

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Achievement',
    'Milestone',
    'Skill',
    'Streak',
    'Special',
  ];

  // Mock data - Replace with actual API call
  final List<custom_badge.Badge> _earnedBadges = [
    custom_badge.Badge(
      id: '1',
      title: 'Early Bird',
      description: 'Completed first course within 2 weeks',
      iconUrl: '🏆',
      category: 'Achievement',
      earnedDate: DateTime(2025, 12, 15),
      rarity: 'Rare',
      pointsEarned: 50,
      relatedCourse: 'Introduction to Programming',
    ),
    custom_badge.Badge(
      id: '2',
      title: 'Week Warrior',
      description: 'Maintained a 7-day learning streak',
      iconUrl: '🔥',
      category: 'Streak',
      earnedDate: DateTime(2026, 1, 5),
      rarity: 'Common',
      pointsEarned: 25,
    ),
    custom_badge.Badge(
      id: '3',
      title: 'Course Crusher',
      description: 'Completed 5 courses',
      iconUrl: '⭐',
      category: 'Milestone',
      earnedDate: DateTime(2026, 1, 10),
      rarity: 'Epic',
      pointsEarned: 100,
    ),
    custom_badge.Badge(
      id: '4',
      title: 'JavaScript Master',
      description: 'Mastered JavaScript fundamentals',
      iconUrl: '💻',
      category: 'Skill',
      earnedDate: DateTime(2025, 11, 20),
      rarity: 'Rare',
      pointsEarned: 75,
      relatedCourse: 'Advanced JavaScript',
    ),
    custom_badge.Badge(
      id: '5',
      title: 'Perfect Score',
      description: 'Scored 100% on a course assessment',
      iconUrl: '🎯',
      category: 'Achievement',
      earnedDate: DateTime(2026, 1, 8),
      rarity: 'Legendary',
      pointsEarned: 150,
      relatedCourse: 'Web Development Basics',
    ),
    custom_badge.Badge(
      id: '6',
      title: 'Social Learner',
      description: 'Participated in 10 discussion forums',
      iconUrl: '💬',
      category: 'Special',
      earnedDate: DateTime(2025, 12, 28),
      rarity: 'Common',
      pointsEarned: 30,
    ),
  ];

  final List<custom_badge.Badge> _lockedBadges = [
    custom_badge.Badge(
      id: '7',
      title: 'Marathon Runner',
      description: 'Maintain a 30-day learning streak',
      iconUrl: '🏃',
      category: 'Streak',
      earnedDate: DateTime.now(),
      rarity: 'Epic',
      pointsEarned: 200,
    ),
    custom_badge.Badge(
      id: '8',
      title: 'Python Expert',
      description: 'Complete all Python courses',
      iconUrl: '🐍',
      category: 'Skill',
      earnedDate: DateTime.now(),
      rarity: 'Legendary',
      pointsEarned: 250,
    ),
    custom_badge.Badge(
      id: '9',
      title: 'Community Champion',
      description: 'Help 50 other learners in forums',
      iconUrl: '🤝',
      category: 'Special',
      earnedDate: DateTime.now(),
      rarity: 'Epic',
      pointsEarned: 180,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<custom_badge.Badge> get _filteredEarnedBadges {
    if (_selectedCategory == 'All') return _earnedBadges;
    return _earnedBadges.where((b) => b.category == _selectedCategory).toList();
  }

  List<custom_badge.Badge> get _filteredLockedBadges {
    if (_selectedCategory == 'All') return _lockedBadges;
    return _lockedBadges.where((b) => b.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final totalPoints = _earnedBadges.fold<int>(
      0,
      (sum, badge) => sum + badge.pointsEarned,
    );

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Badges & Achievements',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: Column(
            children: [
              // Stats Card
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[700]!, Colors.blue[500]!],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      'Earned',
                      '${_earnedBadges.length}',
                      Icons.emoji_events,
                    ),
                    Container(width: 1, height: 40, color: Colors.white30),
                    _buildStatItem('Points', '$totalPoints', Icons.stars),
                    Container(width: 1, height: 40, color: Colors.white30),
                    _buildStatItem(
                      'Locked',
                      '${_lockedBadges.length}',
                      Icons.lock,
                    ),
                  ],
                ),
              ),
              // Tabs
              TabBar(
                controller: _tabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                tabs: const [
                  Tab(text: 'Earned'),
                  Tab(text: 'Locked'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    selectedColor: Colors.blue[100],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.blue[900] : Colors.grey[700],
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          // Badge Grid
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBadgeGrid(_filteredEarnedBadges, isEarned: true),
                _buildBadgeGrid(_filteredLockedBadges, isEarned: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildBadgeGrid(
    List<custom_badge.Badge> badges, {
    required bool isEarned,
  }) {
    if (badges.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isEarned ? Icons.emoji_events_outlined : Icons.lock_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              isEarned
                  ? 'No badges earned yet'
                  : 'No locked badges in this category',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isEarned) ...[
              const SizedBox(height: 8),
              Text(
                'Complete courses to earn badges!',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ],
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: badges.length,
      itemBuilder: (context, index) {
        return _buildBadgeCard(badges[index], isEarned: isEarned);
      },
    );
  }

  Widget _buildBadgeCard(custom_badge.Badge badge, {required bool isEarned}) {
    return GestureDetector(
      onTap: () => _showBadgeDetails(badge, isEarned),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Rarity indicator
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getRarityColor(badge.rarity),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge.rarity,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Badge Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: isEarned ? Colors.blue[50] : Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        badge.iconUrl,
                        style: TextStyle(
                          fontSize: 40,
                          color: isEarned ? null : Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Badge Title
                  Text(
                    badge.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isEarned ? Colors.black87 : Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Points
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.stars,
                        size: 14,
                        color: isEarned ? Colors.amber : Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${badge.pointsEarned} pts',
                        style: TextStyle(
                          fontSize: 12,
                          color: isEarned ? Colors.grey[700] : Colors.grey[500],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  if (isEarned) ...[
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('MMM d, y').format(badge.earnedDate),
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    ),
                  ],
                ],
              ),
            ),
            // Lock overlay for locked badges
            if (!isEarned)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(Icons.lock, size: 32, color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getRarityColor(String rarity) {
    switch (rarity.toLowerCase()) {
      case 'common':
        return Colors.grey;
      case 'rare':
        return Colors.blue;
      case 'epic':
        return Colors.purple;
      case 'legendary':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _showBadgeDetails(custom_badge.Badge badge, bool isEarned) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            // Badge Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: isEarned ? Colors.blue[50] : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  badge.iconUrl,
                  style: const TextStyle(fontSize: 50),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Badge Title
            Text(
              badge.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Rarity
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getRarityColor(badge.rarity),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                badge.rarity,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Description
            Text(
              badge.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Info Grid
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        badge.category,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Points', style: TextStyle(color: Colors.grey[600])),
                      Row(
                        children: [
                          const Icon(
                            Icons.stars,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${badge.pointsEarned}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (isEarned) ...[
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Earned Date',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          DateFormat('MMMM d, y').format(badge.earnedDate),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                  if (badge.relatedCourse != null) ...[
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Related Course',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Flexible(
                          child: Text(
                            badge.relatedCourse!,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            if (!isEarned) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Complete the requirements to unlock this badge',
                        style: TextStyle(color: Colors.blue[900], fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
