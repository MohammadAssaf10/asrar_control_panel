import 'package:asrar_control_panel/features/home/domain/entities/service_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../../../../core/data/firebase_exception_handler.dart';
import '../../domain/repositories/service_repository.dart';

class ServiceRepositoryImpl extends ServiceRepository {
  @override
  Future<Either<Failure, Unit>> addService(
    String companyName,
    String serviceName,
    double servicePrice,
    List<String> requiredDocuments,
  ) async {
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final ServiceEntities serviceEntities = ServiceEntities(
        companyName: companyName,
        serviceName: serviceName,
        servicePrice: servicePrice,
        requiredDocuments: requiredDocuments,
      );
      await db
          .collection("service")
          .doc("$companyName-$serviceName")
          .set(serviceEntities.toMap());
      return const Right(unit);
    } catch (e) {
      return Left(FirebaseExceptionHandler.handle(e).getFailure());
    }
  }
}
