import 'package:asrar_control_panel/core/app/di.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/service_entities.dart';
import '../../../domain/repositories/service_repository.dart';

part 'services_event.dart';

part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final ServiceRepository serviceRepository = instance<ServiceRepository>();

  ServicesBloc() : super(ServicesInitial()) {
    on<AddServiceEvent>(
      (event, emit) async {
        emit(ServiceLoadingState());
        final service =
            await serviceRepository.addService(event.serviceEntities);
        service.fold(
          (failure) => emit(ServiceErrorState(errorMessage: failure.message)),
          (r) => emit(AddedServiceSuccessfullyState()),
        );
      },
    );
    on<GetServicesEvent>((event, emit) async {
      emit(ServiceLoadingState());
      final services = await serviceRepository.getServices(event.companyName);
      services.fold(
          (failure) => emit(ServiceErrorState(errorMessage: failure.message)),
          (services) => emit(ServicesLoadedState(services: services)));
    });
    on<DeleteServiceEvent>((event, emit) async {
      emit(ServiceDeleteLoadingState());
      final service = await serviceRepository.deleteService(
          event.companyName, event.serviceName);
      service.fold(
          (failure) =>
              emit(DeleteServiceErrorState(errorMessage: failure.message)),
          (r) =>
              emit(ServiceDeletedSuccessfully(companyName: event.companyName)));
    });
  }
}
