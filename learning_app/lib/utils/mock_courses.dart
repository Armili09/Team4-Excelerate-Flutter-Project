import '../models/course.dart';

List<Course> mockCourses = [
  Course(
    id: '1',
    title: 'Flutter for Beginners',
    description: 'Learn Flutter from scratch',
    progress: 0.6,
    status: CourseStatus.inProgress,
  ),
  Course(
    id: '2',
    title: 'Dart Fundamentals',
    description: 'Master the Dart language',
    progress: 1.0,
    status: CourseStatus.completed,
  ),
  Course(
    id: '3',
    title: 'UI Design Basics',
    description: 'Design better mobile UIs',
    progress: 0.0,
    status: CourseStatus.saved,
  ),
];
