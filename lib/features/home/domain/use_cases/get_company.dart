import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/company.dart';
import '../repositories/company_repository.dart';

class GetCompanyUseCase {
  final CompanyRepository companyRepository;

  const GetCompanyUseCase({required this.companyRepository});

  Future<Either<Failure, List<CompanyEntities>>> call() async {
    return companyRepository.getCompany();
  }
}
