part of 'services_bloc.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();
}

class AddServicesEvent extends ServicesEvent {
  final ServiceEntities serviceEntities;

  const AddServicesEvent({required this.serviceEntities});

  @override
  List<Object?> get props => [serviceEntities];
}
