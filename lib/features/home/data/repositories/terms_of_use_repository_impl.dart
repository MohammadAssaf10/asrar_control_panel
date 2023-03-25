import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/strings_manager.dart';
import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/repositories/terms_of_use_repository.dart';

class TermsOfUseRepositoryImpl extends TermsOfUseRepository{
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<Either<Failure, Unit>> addTermsOfUse(String termsOfUse) async {
    try {
      await _firestore
          .collection(FireBaseCollection.termsOfUse)
          .doc(FireBaseCollection.termsOfUse)
          .set({FireBaseCollection.termsOfUse: termsOfUse});
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, String>> getTermsOfUse() async {
    try {
      String termsOfUse = "";
      final termsOfUseDoc = await _firestore
          .collection(FireBaseCollection.termsOfUse)
          .doc(FireBaseCollection.termsOfUse)
          .get();
      if (termsOfUseDoc.exists) {
        termsOfUse = termsOfUseDoc[FireBaseCollection.termsOfUse];
      }
      return Right(termsOfUse);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTermsOfUse(String termsOfUse) async {
    try {
      final termsOfUseDoc = await _firestore
          .collection(FireBaseCollection.termsOfUse)
          .doc(FireBaseCollection.termsOfUse)
          .get();
      if (termsOfUseDoc.exists) {
        await _firestore
            .collection(FireBaseCollection.termsOfUse)
            .doc(FireBaseCollection.termsOfUse)
            .update({FireBaseCollection.termsOfUse: termsOfUse});
        return const Right(unit);
      } else {
        final Failure failure = Failure(0, AppStrings.noInformationToUpdateIt);
        return Left(failure);
      }
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

}