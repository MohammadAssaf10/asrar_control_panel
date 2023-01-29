part of 'company_bloc.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();
}

class GetCompaniesListEvent extends CompanyEvent {
  @override
  List<Object?> get props => [];
}

class AddCompanyEvent extends CompanyEvent {
  final XFileEntities xFileEntities;
  final String companyFullName;
  final String docName;

  const AddCompanyEvent({
    required this.companyFullName,
    required this.docName,
    required this.xFileEntities,
  });

  @override
  List<Object?> get props => [xFileEntities, companyFullName, docName];
}

class DeleteCompanyEvent extends CompanyEvent {
  final String companyFullName;
  final String companyName;
  const DeleteCompanyEvent(
      {required this.companyFullName, required this.companyName});
  @override
  List<Object?> get props => [companyFullName, companyName];
}

class EditCompanyEvent extends CompanyEvent {
  final String companyName;
  final int newRanking;
  final int oldRanking;
  const EditCompanyEvent({
    required this.companyName,
    required this.newRanking,
    required this.oldRanking,
  });

  @override
  List<Object?> get props => [companyName, newRanking, oldRanking];
}
