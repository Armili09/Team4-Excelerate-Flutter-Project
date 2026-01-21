class Badge {
  final String id;
  final String title;
  final String description;
  final String iconUrl;
  final String category;
  final DateTime earnedDate;
  final String rarity;
  final int pointsEarned;
  final String? relatedCourse;

  Badge({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.category,
    required this.earnedDate,
    required this.rarity,
    required this.pointsEarned,
    this.relatedCourse,
  });

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      iconUrl: json['iconUrl'] ?? '',
      category: json['category'] ?? 'General',
      earnedDate: DateTime.parse(json['earnedDate'] ?? DateTime.now().toIso8601String()),
      rarity: json['rarity'] ?? 'Common',
      pointsEarned: json['pointsEarned'] ?? 0,
      relatedCourse: json['relatedCourse'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iconUrl': iconUrl,
      'category': category,
      'earnedDate': earnedDate.toIso8601String(),
      'rarity': rarity,
      'pointsEarned': pointsEarned,
      'relatedCourse': relatedCourse,
    };
  }
}
