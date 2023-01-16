import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/company.dart';
import '../../../domain/entities/xfile_entities.dart';
import '../../../domain/repositories/company_repository.dart';
import '../../../domain/repositories/storage_file_repository.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyRepository companyRepository = instance<CompanyRepository>();
  final StorageFileRepository storageFileRepository =
      instance<StorageFileRepository>();

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
    on<AddCompanyEvent>((event, emit) async {
      emit(CompanyLoadingState());
      final uploadImage = await storageFileRepository.uploadFile(
          event.xFileEntities, "company");
      uploadImage.fold((failure) {
        print("uploadImage------>${failure.message}");
        emit(CompanyErrorState(errorMessage: failure.message));
      }, (r) async {
        print("uploadImage------>Done");
        final company = await companyRepository.addCompany(
            "company", event.companyName, event.docName);
        print("add company------>Done");
        emit(CompanyAddedSuccessfully());
      });
    });
  }
}
