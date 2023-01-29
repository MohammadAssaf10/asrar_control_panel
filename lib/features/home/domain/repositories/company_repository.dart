import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/company.dart';

abstract class CompanyRepository {
  Future<Either<Failure, Unit>> addCompany(
      String companyFullName, String docName);
  // companyFullName: Name with subsequent(.jpg or .png)
  // companyName: Just name without subsequent
  Future<Either<Failure, Unit>> deleteCompany(
      String companyFullName, String companyName);
  Future<Either<Failure, List<CompanyEntities>>> getCompany();
  Future<int> getLastCompanyRanking();
  Future<Either<Failure, Unit>> updateCompanyRanking(
      String companyName, int newRanking, int oldRanking);
}
