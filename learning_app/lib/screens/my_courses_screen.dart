import 'package:flutter/material.dart';
import '../models/course.dart';
import '../services/data_service.dart';
import 'course_detail_screen.dart';

enum CourseFilter { all, inProgress, completed }

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  late Future<List<Course>> _futureCourses;
  CourseFilter _filter = CourseFilter.all;

  @override
  void initState() {
    super.initState();
    _futureCourses = _loadCourses();
  }

  Future<List<Course>> _loadCourses() async {
    final json = await DataService().fetchMyCourses();
    return json.map((e) => Course.fromJson(e)).toList();
  }

  List<Course> _filteredCourses(List<Course> courses) {
    switch (_filter) {
      case CourseFilter.inProgress:
        return courses.where((c) => c.status == 'in_progress').toList();
      case CourseFilter.completed:
        return courses.where((c) => c.status == 'completed').toList();
      default:
        return courses;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Courses'), centerTitle: true),
      body: Column(
        children: [
          /// SEGMENTED FILTER BAR
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF11283E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: CourseFilter.values.map((filter) {
                  final bool selected = _filter == filter;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _filter = filter),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _label(filter),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: selected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          /// COURSE LIST
          Expanded(
            child: FutureBuilder<List<Course>>(
              future: _futureCourses,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Failed to load courses',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                final courses = _filteredCourses(snapshot.data ?? []);

                if (courses.isEmpty) {
                  return const _EmptyState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            LinearProgressIndicator(
                              value: course.progress,
                              minHeight: 6,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${(course.progress * 100).round()}% • ${course.status.replaceAll('_', ' ')}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CourseDetailScreen(course: course),
                                    ),
                                  );
                                },
                                child: const Text('View Details'),
                              ),
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

  String _label(CourseFilter filter) {
    switch (filter) {
      case CourseFilter.inProgress:
        return 'In Progress';
      case CourseFilter.completed:
        return 'Completed';
      default:
        return 'All';
    }
  }
}

/// EMPTY STATE
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.school_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 12),
          Text('No courses found', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
