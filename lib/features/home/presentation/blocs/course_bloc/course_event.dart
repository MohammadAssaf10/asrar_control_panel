part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class AddCourseEvent extends CourseEvent {
  final CourseEntities course;
  final XFileEntities xFileEntities;
  const AddCourseEvent({
    required this.course,
    required this.xFileEntities,
  });
  @override
  List<Object?> get props => [course, xFileEntities];
}

class GetCourseListEvent extends CourseEvent {
  @override
  List<Object?> get props => [];
}

class DeleteCourseEvent extends CourseEvent {
  final CourseEntities course;
  const DeleteCourseEvent({required this.course});

  @override
  List<Object?> get props => [course];
}
