import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.blueAccent;
    final Color bgColor = const Color(0xFF101922);
    final Color cardColor = const Color(0xFF161E26);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(course.title),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// DESCRIPTION
            const SizedBox(height: 8),
            Text(
              course.description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            /// PROGRESS CIRCULAR
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: course.progress,
                      strokeWidth: 10,
                      backgroundColor: Colors.grey.shade800,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    '${(course.progress * 100).round()}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            /// RATING & REVIEWS
            Card(
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        if (index < course.rating.floor()) {
                          return const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 22,
                          );
                        } else if (index < course.rating) {
                          return const Icon(
                            Icons.star_half,
                            color: Colors.amber,
                            size: 22,
                          );
                        } else {
                          return const Icon(
                            Icons.star_border,
                            color: Colors.amber,
                            size: 22,
                          );
                        }
                      }),
                    ),
                    Text(
                      '${course.reviews} Reviews',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Learning Milestones',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  _TimelineMilestone(
                    label: 'Started',
                    completed: course.progress > 0.0,
                    primaryColor: primaryColor,
                    isFirst: true,
                    isLast: false,
                  ),
                  _TimelineMilestone(
                    label: 'Midway',
                    completed: course.progress >= 0.5,
                    primaryColor: primaryColor,
                    isFirst: false,
                    isLast: false,
                  ),
                  _TimelineMilestone(
                    label: 'Certified',
                    completed: course.progress >= 1.0,
                    primaryColor: primaryColor,
                    isFirst: false,
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            /// SYLLABUS / MODULES (refined)
            const Text(
              'Syllabus',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: course.modules.map((m) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 6,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: m.completed
                            ? primaryColor
                            : Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    title: Text(
                      m.title,
                      style: TextStyle(
                        fontWeight: m.completed
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      m.subtitle,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: Icon(
                      m.completed ? Icons.check_circle : Icons.lock,
                      color: m.completed ? primaryColor : Colors.grey.shade600,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            /// INSTRUCTOR
            const Text(
              'Instructor',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(course.instructorImage),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.instructor,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          course.level,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _TimelineMilestone extends StatelessWidget {
  final String label;
  final bool completed;
  final Color primaryColor;
  final bool isFirst;
  final bool isLast;

  const _TimelineMilestone({
    required this.label,
    required this.completed,
    required this.primaryColor,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                if (!isFirst)
                  Expanded(
                    child: Container(
                      height: 4,
                      color: completed ? primaryColor : Colors.grey.shade700,
                    ),
                  ),
                CircleAvatar(
                  radius: 14,
                  backgroundColor: completed
                      ? primaryColor
                      : Colors.grey.shade700,
                  child: completed
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      height: 4,
                      color: completed ? primaryColor : Colors.grey.shade700,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: completed ? primaryColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

/// Milestone Dot
class _MilestoneDot extends StatelessWidget {
  final String label;
  final bool completed;
  final Color primaryColor;

  const _MilestoneDot({
    required this.label,
    required this.completed,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: completed ? primaryColor : Colors.grey,
            shape: BoxShape.circle,
          ),
          child: completed
              ? const Icon(Icons.check, size: 14, color: Colors.white)
              : null,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: completed ? primaryColor : Colors.grey,
          ),
        ),
      ],
    );
  }
}
