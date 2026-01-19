import 'package:flutter/material.dart';
import '../models/course.dart';
import 'course_detail_screen.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final inProgress = Course.mockInProgress();
    final saved = Course.mockSaved();
    final completed = Course.mockCompleted();

    return Scaffold(
      appBar: AppBar(title: const Text("My Courses")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            "In Progress",
            inProgress,
            CourseCardType.inProgress,
          ),
          _buildSection(context, "Saved", saved, CourseCardType.saved),
          _buildSection(
            context,
            "Completed",
            completed,
            CourseCardType.completed,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Course> courses,
    CourseCardType type,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (courses.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'No courses here yet. Browse programs to get started!',
              style: TextStyle(color: Colors.grey),
            ),
          )
        else
          ...courses.map((c) => CourseCard(course: c, type: type)),
        const SizedBox(height: 24),
      ],
    );
  }
}

enum CourseCardType { inProgress, saved, completed }

class CourseCard extends StatelessWidget {
  final Course course;
  final CourseCardType type;

  const CourseCard({super.key, required this.course, required this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // same height
      width: double.infinity, // <-- make the card stretch full width
      child: Card(
        color: const Color(0xFF1A3750),
        margin: const EdgeInsets.only(bottom: 12),
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
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (type) {
      case CourseCardType.inProgress:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            LinearProgressIndicator(
              value: course.progress,
              color: const Color(0xFF1C64F2), // blue variant
              backgroundColor: Colors.grey.shade800,
            ),
            const SizedBox(height: 6),
            Text(
              '${(course.progress * 100).toInt()}% • Ends ${course.endDate ?? "-"}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );

      case CourseCardType.saved:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              MainAxisAlignment.center, // center content vertically
          children: [
            Text(
              course.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              '${course.duration ?? "-"} • ${course.level ?? "-"}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );

      case CourseCardType.completed:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              MainAxisAlignment.center, // center content vertically
          children: [
            Text(
              course.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Done • ${course.completionDate ?? "-"}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
    }
  }
}
