import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';

abstract class TermsOfUseRepository {
  Future<Either<Failure, Unit>> addTermsOfUse(String termsOfUse);
  Future<Either<Failure, Unit>> updateTermsOfUse(String termsOfUse);
  Future<Either<Failure, String>> getTermsOfUse();
}
