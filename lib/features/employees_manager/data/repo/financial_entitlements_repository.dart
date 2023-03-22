import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/entities/financial_entitlements.dart';

const String kFinancialEntitlements = 'FinancialEntitlements';

class FinancialEntitlementsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<Failure, List<FinancialEntitlements>>> getFinancialEntitlements() async {
    try {
      List<FinancialEntitlements> list = [];

      var docs = (await _firestore.collection(kFinancialEntitlements).get()).docs;

      for (var doc in docs) {
        list.add(FinancialEntitlements.fromMap(doc.data()));
      }

      return Right(list);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, void>> updateFinancialEntitlements(
      FinancialEntitlements financialEntitlements) async {
    try {
      (await _firestore
          .collection(kFinancialEntitlements)
          .doc(financialEntitlements.beneficiaryId)
          .update(financialEntitlements.toMap()));

      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
