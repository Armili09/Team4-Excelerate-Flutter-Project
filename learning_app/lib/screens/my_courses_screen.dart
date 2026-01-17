import 'package:flutter/material.dart';
import '../models/course.dart';
import '../utils/mock_courses.dart';
import 'course_detail_screen.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final inProgress = mockCourses
        .where((c) => c.status == CourseStatus.inProgress)
        .toList();
    final saved = mockCourses
        .where((c) => c.status == CourseStatus.saved)
        .toList();
    final completed = mockCourses
        .where((c) => c.status == CourseStatus.completed)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("My Courses")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            "In Progress",
            inProgress,
            Colors.yellow.shade700,
          ),
          _buildSection(context, "Saved", saved, Colors.grey.shade600),
          _buildSection(context, "Completed", completed, Colors.green.shade600),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Course> courses,
    Color progressColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (courses.isEmpty)
          _emptyState(title)
        else
          ...courses.map((c) => _courseCard(context, c, progressColor)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _emptyState(String section) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          "No $section courses yet.\nBrowse programs to get started!",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _courseCard(BuildContext context, Course course, Color progressColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      shadowColor: Colors.black45,
      color: const Color(0xFF2A3A60), // slightly lighter than background
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CourseDetailScreen(course: course),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                course.description,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: course.progress,
                  minHeight: 8,
                  color: progressColor,
                  backgroundColor: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "${(course.progress * 100).toInt()}% completed",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
