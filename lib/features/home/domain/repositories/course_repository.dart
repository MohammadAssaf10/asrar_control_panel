import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/course_entities.dart';

abstract class CourseRepository {
  Future<Either<Failure, Unit>> addCourse(
    CourseEntities course,
    String courseImageUrl,
  );
  Future<Either<Failure, List<CourseEntities>>> getCoursesList();
  Future<Either<Failure, Unit>> deleteCourse(
    CourseEntities course,
  );
}
