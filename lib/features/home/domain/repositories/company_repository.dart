import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/company.dart';

abstract class CompanyRepository {
  Future<Either<Failure, Unit>> addCompany(
      String folderName, String fileName, String docName);

  Future<Either<Failure, List<CompanyEntities>>> getCompany();
}
