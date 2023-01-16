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
    on<AddServicesEvent>(
      (event, emit) async {
        emit(AddedServiceLoadingState());
        final service =
            await serviceRepository.addService(event.serviceEntities);
        service.fold(
          (failure) =>
              emit(AddedServiceErrorState(errorMessage: failure.message)),
          (r) => emit(AddedServiceSuccessfullyState()),
        );
      },
    );
  }
}
