part of 'services_bloc.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();
}

class AddServiceEvent extends ServicesEvent {
  final ServiceEntities serviceEntities;

  const AddServiceEvent({required this.serviceEntities});

  @override
  List<Object?> get props => [serviceEntities];
}

class DeleteServiceEvent extends ServicesEvent {
  final String serviceName;
  final String companyName;
  const DeleteServiceEvent({
    required this.serviceName,
    required this.companyName,
  });

  @override
  List<Object?> get props => [serviceName, companyName];
}

class GetServicesListEvent extends ServicesEvent {
  final String companyName;
  const GetServicesListEvent({required this.companyName});
  @override
  List<Object?> get props => [companyName];
}
