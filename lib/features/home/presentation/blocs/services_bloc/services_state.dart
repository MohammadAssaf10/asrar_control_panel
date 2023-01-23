part of 'services_bloc.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();
}

class ServicesInitial extends ServicesState {
  @override
  List<Object> get props => [];
}

class ServiceLoadingState extends ServicesState {
  @override
  List<Object?> get props => [];
}

class ServiceDeleteLoadingState extends ServicesState {
  @override
  List<Object?> get props => [];
}

class ServiceErrorState extends ServicesState {
  final String errorMessage;

  const ServiceErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class DeleteServiceErrorState extends ServicesState {
  final String errorMessage;
  const DeleteServiceErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class AddedServiceSuccessfullyState extends ServicesState {
  @override
  List<Object?> get props => [];
}

class ServicesLoadedState extends ServicesState {
  final List<ServiceEntities> services;

  const ServicesLoadedState({required this.services});
  @override
  List<Object?> get props => [services];
}
class ServiceDeletedSuccessfully extends ServicesState {
  final String companyName;
  const ServiceDeletedSuccessfully({required this.companyName});
  @override
  List<Object?> get props => [companyName];
}
