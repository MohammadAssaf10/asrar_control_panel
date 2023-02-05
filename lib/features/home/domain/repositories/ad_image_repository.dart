import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/ad_image_entities.dart';

abstract class AdImageRepository {
  Future<Either<Failure, Unit>> addAdImage(AdImageEntities adImageEntities,String adImageUrl);
  Future<Either<Failure, Unit>> deleteAdImage(AdImageEntities adImage);
  Future<Either<Failure, List<AdImageEntities>>> getAdImages();
}
