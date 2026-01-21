class Course {
  final String title;

  /// For in-progress courses
  final double progress;
  final String? endDate;

  /// For saved courses
  final String? duration;
  final String? level;

  /// For completed courses
  final String? completionDate;

  Course({
    required this.title,
    this.progress = 0.0,
    this.endDate,
    this.duration,
    this.level,
    this.completionDate,
  });

  /// ---------------------------
  /// MOCK DATA HELPERS
  /// ---------------------------

  static List<Course> mockInProgress() {
    return [
      Course(title: 'Flutter Development', progress: 0.6, endDate: 'Mar 2026'),
      Course(
        title: 'Cloud Computing Basics',
        progress: 0.3,
        endDate: 'Apr 2026',
      ),
    ];
  }

  static List<Course> mockSaved() {
    return [
      Course(
        title: 'Machine Learning 101',
        duration: '8 weeks',
        level: 'Beginner',
      ),
      Course(title: 'UI/UX Design', duration: '6 weeks', level: 'Intermediate'),
    ];
  }

  static List<Course> mockCompleted() {
    return [
      Course(title: 'Git & GitHub', completionDate: 'Dec 2025'),
      Course(title: 'Dart Fundamentals', completionDate: 'Nov 2025'),
    ];
  }
}
