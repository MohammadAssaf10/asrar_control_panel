part of 'services_bloc.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();
}

class ServicesInitial extends ServicesState {
  @override
  List<Object> get props => [];
}

class AddedServiceLoadingState extends ServicesState {
  @override
  List<Object?> get props => [];
}

class AddedServiceErrorState extends ServicesState {
  final String errorMessage;

  const AddedServiceErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class AddedServiceSuccessfullyState extends ServicesState {
  @override
  List<Object?> get props => [];
}
