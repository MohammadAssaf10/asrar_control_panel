part of 'job_bloc.dart';

abstract class JobState extends Equatable {
  const JobState();
}

class JobInitial extends JobState {
  @override
  List<Object?> get props => [];
}

class JobLoadingState extends JobState {
  @override
  List<Object?> get props => [];
}

class DeleteJobLoadingState extends JobState {
  @override
  List<Object?> get props => [];
}

class JobErrorState extends JobState {
  final String errorMessage;
  const JobErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class GetJobErrorState extends JobState {
  final String errorMessage;
  const GetJobErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class JobAddedSuccessfullyState extends JobState {
  @override
  List<Object?> get props => [];
}

class JobDeletedSuccessfullyState extends JobState {
  @override
  List<Object?> get props => [];
}

class JobsLoadedState extends JobState {
  final List<JobEntities> jobsList;
  const JobsLoadedState({required this.jobsList});
  @override
  List<Object?> get props => [jobsList];
}
