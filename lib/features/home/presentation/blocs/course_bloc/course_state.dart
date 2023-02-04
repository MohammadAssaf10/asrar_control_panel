part of 'course_bloc.dart';

abstract class CourseState extends Equatable {
  const CourseState();
}

class CourseInitial extends CourseState {
  @override
  List<Object?> get props => [];
}

class CourseLoadingState extends CourseState {
  @override
  List<Object?> get props => [];
}

class DeleteCourseLoadingState extends CourseState {
  @override
  List<Object?> get props => [];
}

class CourseErrorState extends CourseState {
  final String errorMessage;
  const CourseErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class GetCourseErrorState extends CourseState {
  final String errorMessage;
  const GetCourseErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class CourseAddedSuccessfullyState extends CourseState {
  @override
  List<Object?> get props => [];
}

class CourseDeletedSuccessfullyState extends CourseState {
  @override
  List<Object?> get props => [];
}

class CourseLoadedState extends CourseState {
  final List<CourseEntities> coursesList;
  const CourseLoadedState({required this.coursesList});
  @override
  List<Object?> get props => [coursesList];
}
