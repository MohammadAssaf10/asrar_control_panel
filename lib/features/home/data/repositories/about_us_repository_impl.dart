import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/strings_manager.dart';
import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/repositories/about_us_repository.dart';

class AboutUsRepositoryImpl extends AboutUsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<Either<Failure, Unit>> addAboutUs(String aboutUs) async {
    try {
      await _firestore
          .collection(FireBaseCollection.aboutUs)
          .doc(FireBaseCollection.aboutUs)
          .set({FireBaseCollection.aboutUs: aboutUs});
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, String>> getAboutUs() async {
    try {
      String aboutUs = "";
      final aboutUsDoc = await _firestore
          .collection(FireBaseCollection.aboutUs)
          .doc(FireBaseCollection.aboutUs)
          .get();
      if (aboutUsDoc.exists) {
        aboutUs = aboutUsDoc[FireBaseCollection.aboutUs];
      }
      return Right(aboutUs);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> updateAboutUs(String aboutUs) async {
    try {
      final aboutUsDoc = await _firestore
          .collection(FireBaseCollection.aboutUs)
          .doc(FireBaseCollection.aboutUs)
          .get();
      if (aboutUsDoc.exists) {
        await _firestore
            .collection(FireBaseCollection.aboutUs)
            .doc(FireBaseCollection.aboutUs)
            .update({FireBaseCollection.aboutUs: aboutUs});
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
