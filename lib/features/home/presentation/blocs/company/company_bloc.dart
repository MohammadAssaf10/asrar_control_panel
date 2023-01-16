import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/company.dart';
import '../../../domain/entities/xfile_entities.dart';
import '../../../domain/repositories/company_repository.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyRepository companyRepository = instance<CompanyRepository>();
  CompanyBloc() : super(CompanyInitial()) {
    on<GetCompanyEvent>((event, emit) async {
      emit(CompanyLoadingState());
      final company = await companyRepository.getCompany();
      company.fold(
        (failure) => emit(CompanyErrorState(errorMessage: failure.message)),
        (company) => emit(
          CompanyLoadedState(company: company),
        ),
      );
    });
  }
}
