import 'package:asrar_control_panel/core/app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/entities/ad_image_entities.dart';
import '../../domain/repositories/ad_image_repository.dart';

class AdImageRepositoryImpl extends AdImageRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<Either<Failure, Unit>> addAdImage(
      AdImageEntities adImageEntities, String adImageUrl) async {
    try {
      Map<String, dynamic> adImage = AdImageEntities(
              adImageName: adImageEntities.adImageName,
              adImageUrl: adImageUrl,
              adImagedeepLink: adImageEntities.adImagedeepLink)
          .toMap();
      await db
          .collection(FireBaseCollection.adImages)
          .doc(adImageEntities.adImageName)
          .set(adImage);
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAdImage(AdImageEntities adImage) async {
    try {
      await db
          .collection(FireBaseCollection.adImages)
          .doc(adImage.adImageName)
          .delete();
      await FirebaseStorage.instance
          .ref("${FireBaseCollection.adImages}/${adImage.adImageName}")
          .delete();
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<AdImageEntities>>> getAdImages() async {
    try {
      List<AdImageEntities> adImagesList = [];
      final adImages = await db.collection(FireBaseCollection.adImages).get();
      for (var doc in adImages.docs) {
        adImagesList.add(AdImageEntities.fromMap(doc.data()));
      }
      return Right(adImagesList);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
