import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/entities/course_entities.dart';
import '../../domain/repositories/course_repository.dart';

class CourseRepositoryImpl extends CourseRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<Either<Failure, Unit>> addCourse(
    CourseEntities course,
    String courseImageUrl,
  ) async {
    try {
      final Map<String, dynamic> courseEntities = CourseEntities(
        timestamp: course.timestamp,
        courseTitile: course.courseTitile,
        courseContent: course.courseContent,
        coursePrice: course.coursePrice,
        courseImageName: course.courseImageName,
        courseImageUrl: courseImageUrl,
      ).toMap();
      await db
          .collection(FireBaseCollection.courses)
          .doc(course.courseTitile)
          .set(courseEntities);
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCourse(CourseEntities course) async {
    try {
      await db
          .collection(FireBaseCollection.courses)
          .doc(course.courseTitile)
          .delete();
      await FirebaseStorage.instance
          .ref("${FireBaseCollection.courses}/${course.courseImageName}")
          .delete();
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<CourseEntities>>> getCoursesList() async {
    try {
      final List<CourseEntities> coursesList = [];
      final courses = await db.collection(FireBaseCollection.courses).get();
      for (var doc in courses.docs) {
        coursesList.add(CourseEntities.fromMap(doc.data()));
      }
      coursesList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return Right(coursesList);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
