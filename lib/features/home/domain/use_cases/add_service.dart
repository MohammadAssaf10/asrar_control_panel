import 'package:asrar_control_panel/features/home/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/service_entities.dart';

class AddServiceUseCase {
  final ServiceRepository serviceRepository;

  AddServiceUseCase({required this.serviceRepository});

  Future<Either<Failure, Unit>> call(ServiceEntities serviceEntities) async {
    return await serviceRepository.addService(serviceEntities);
  }
}
