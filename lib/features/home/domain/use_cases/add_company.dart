import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../repositories/company_repository.dart';


class AddCompanyUseCase {
  final CompanyRepository companyRepository;

  const AddCompanyUseCase({required this.companyRepository});

  Future<Either<Failure, Unit>> call(
      String folderName, String fileName, String docName)async {
    return companyRepository.addCompany(folderName, fileName, docName);
  }
}
