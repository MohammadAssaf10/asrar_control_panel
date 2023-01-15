import 'package:asrar_control_panel/features/home/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';

class AddServiceUseCase {
  final ServiceRepository serviceRepository;

  AddServiceUseCase({required this.serviceRepository});

  Future<Either<Failure, Unit>> call(
    String companyName,
    String serviceName,
    double servicePrice,
    List<String> requiredDocuments,
  ) async {
    return serviceRepository.addService(
        companyName, serviceName, servicePrice, requiredDocuments);
  }
}
