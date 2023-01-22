import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/service_entities.dart';

abstract class ServiceRepository {
  Future<Either<Failure, Unit>> addService(
  ServiceEntities serviceEntities
  );
}
