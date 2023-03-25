import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';

abstract class AboutUsRepository {
  Future<Either<Failure, Unit>> addAboutUs(String aboutUs);
  Future<Either<Failure, Unit>> updateAboutUs(String aboutUs);
  Future<Either<Failure, String>> getAboutUs();
}
