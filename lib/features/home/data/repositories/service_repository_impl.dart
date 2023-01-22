import 'package:asrar_control_panel/features/home/domain/entities/service_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/repositories/service_repository.dart';

class ServiceRepositoryImpl extends ServiceRepository {
  @override
  Future<Either<Failure, Unit>> addService(
      ServiceEntities serviceEntities) async {
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      await db
          .collection("service")
          .doc("${serviceEntities.companyName}-${serviceEntities.serviceName}")
          .set(serviceEntities.toMap());
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
