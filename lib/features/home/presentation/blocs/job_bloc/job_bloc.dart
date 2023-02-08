import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/constants.dart';
import '../../../../../core/app/di.dart';
import '../../../domain/entities/job_entitiies.dart';
import '../../../domain/entities/xfile_entities.dart';
import '../../../domain/repositories/job_repository.dart';
import '../../../domain/repositories/storage_file_repository.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepository jobRepository = instance<JobRepository>();
  final StorageFileRepository storageFileRepository =
      instance<StorageFileRepository>();

  JobBloc() : super(JobInitial()) {
    on<AddJobEvent>((event, emit) async {
      emit(JobLoadingState());
      await (await storageFileRepository.uploadFile(
              event.xFileEntities, FireBaseCollection.jobs))
          .fold((failure) {
        emit(JobErrorState(errorMessage: failure.message));
      }, (image) async {
        (await jobRepository.addJob(event.job, image.url)).fold((failure) {
          emit(JobErrorState(errorMessage: failure.message));
        }, (r) {
          emit(JobAddedSuccessfullyState());
        });
      });
    });
    on<DeleteJobEvent>((event, emit) async {
      emit(DeleteJobLoadingState());
      (await jobRepository.deleteJob(event.job)).fold((failure) {
        emit(JobErrorState(errorMessage: failure.message));
      }, (r) {
        emit(JobDeletedSuccessfullyState());
      });
    });
    on<GetJobsListEvent>((event, emit) async {
      emit(JobLoadingState());
      (await jobRepository.getJobsList()).fold((failure) {
        emit(GetJobErrorState(errorMessage: failure.message));
      }, (jobsList) {
        emit(JobsLoadedState(jobsList: jobsList));
      });
    });
  }
}
