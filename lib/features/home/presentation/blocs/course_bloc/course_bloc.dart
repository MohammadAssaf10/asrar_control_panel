import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/constants.dart';
import '../../../../../core/app/di.dart';
import '../../../domain/entities/course_entities.dart';
import '../../../domain/entities/xfile_entities.dart';
import '../../../domain/repositories/course_repository.dart';
import '../../../domain/repositories/storage_file_repository.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository newsRepository = instance<CourseRepository>();
  final StorageFileRepository storageFileRepository =
      instance<StorageFileRepository>();

  CourseBloc() : super(CourseInitial()) {
    on<AddCourseEvent>((event, emit) async {
      emit(CourseLoadingState());
      await (await storageFileRepository.uploadFile(
              event.xFileEntities, FireBaseCollection.courses))
          .fold((failure) {
        emit(CourseErrorState(errorMessage: failure.message));
      }, (image) async {
        (await newsRepository.addCourse(event.course, image.url)).fold(
            (failure) {
          emit(CourseErrorState(errorMessage: failure.message));
        }, (r) {
          emit(CourseAddedSuccessfullyState());
        });
      });
    });
    on<DeleteCourseEvent>((event, emit) async {
      emit(DeleteCourseLoadingState());
      (await newsRepository.deleteCourse(event.course)).fold((failure) {
        emit(CourseErrorState(errorMessage: failure.message));
      }, (r) {
        emit(CourseDeletedSuccessfullyState());
      });
    });
    on<GetCourseListEvent>((event, emit) async {
      emit(CourseLoadingState());
      (await newsRepository.getCoursesList()).fold((failure) {
        emit(GetCourseErrorState(errorMessage: failure.message));
      }, (coursesList) {
        emit(CourseLoadedState(coursesList: coursesList));
      });
    });
  }
}
