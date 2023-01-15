import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';

abstract class ServiceRepository {
  Future<Either<Failure, Unit>> addService(
    String companyName,
    String serviceName,
    double servicePrice,
    List<String> requiredDocuments,
  );
}
