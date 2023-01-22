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
class AddCompanyToStore extends CompanyEvent{
  final String companyName;
  final String docName;
  const AddCompanyToStore({
    required this.companyName,
    required this.docName,
  });
  @override
  List<Object?> get props => [companyName,docName];
}