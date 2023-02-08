part of 'job_bloc.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();
}

class AddJobEvent extends JobEvent {
  final JobEntities job;
  final XFileEntities xFileEntities;
  const AddJobEvent({
    required this.job,
    required this.xFileEntities,
  });
  @override
  List<Object?> get props => [job, xFileEntities];
}

class GetJobsListEvent extends JobEvent {
  @override
  List<Object?> get props => [];
}

class DeleteJobEvent extends JobEvent {
  final JobEntities job;
  const DeleteJobEvent({required this.job});

  @override
  List<Object?> get props => [job];
}
