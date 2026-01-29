import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (course.status) {
      case 'completed':
        statusColor = Colors.green.shade400;
        break;
      case 'in_progress':
        statusColor = Colors.orange.shade400;
        break;
      default:
        statusColor = Colors.grey.shade400;
    }

    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE + STATUS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    course.status.replaceAll('_', ' ').toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// PROGRESS BAR
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: course.progress,
                minHeight: 12,
                backgroundColor: Colors.grey.shade800,
                valueColor: AlwaysStoppedAnimation(statusColor),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(course.progress * 100).round()}% completed',
              style: TextStyle(color: Colors.grey.shade400),
            ),
            const SizedBox(height: 16),

            /// DATES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Start: ${course.startDate}',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                Text(
                  'End: ${course.endDate}',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// COURSE MODULES (mock JSON structure)
            const Text(
              'Modules',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: course.modules.length,
                itemBuilder: (context, index) {
                  final module = course.modules[index];
                  return ListTile(
                    leading: Icon(
                      module['completed'] ? Icons.check_circle : Icons.circle,
                      color: module['completed']
                          ? Colors.green
                          : Colors.grey.shade600,
                    ),
                    title: Text(module['title']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
