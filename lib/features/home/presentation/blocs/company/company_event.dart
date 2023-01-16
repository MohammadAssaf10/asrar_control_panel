part of 'company_bloc.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();
}

class GetCompanyEvent extends CompanyEvent {
  @override
  List<Object?> get props => [];
}

class AddCompanyEvent extends CompanyEvent {
  final XFileEntities xFileEntities;
  final String companyName;
  final String docName;

  const AddCompanyEvent({
    required this.companyName,
    required this.docName,
    required this.xFileEntities,
  });

  @override
  List<Object?> get props => [xFileEntities, companyName,docName];
}
