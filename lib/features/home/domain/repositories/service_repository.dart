import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../../../chat/domain/entities/message.dart';
import '../entities/service_entities.dart';
import '../entities/service_order.dart';

abstract class ServiceRepository {
  Future<Either<Failure, Unit>> addService(ServiceEntities serviceEntities);

  Future<Either<Failure, Unit>> deleteService(
      String companyName, String serviceName);

  Future<Either<Failure, List<ServiceEntities>>> getServices(
      String companyName);

  Future<Either<Failure, List<ServiceOrder>>> getServiceOrder();

  Future<Either<Failure, Stream<List<Message>>>> getServiceOrderChat(
      int serviceOrderId);
}
