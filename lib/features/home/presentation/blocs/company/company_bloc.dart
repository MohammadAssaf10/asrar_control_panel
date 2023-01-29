import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app/constants.dart';
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
    on<GetCompaniesListEvent>((event, emit) async {
      emit(CompanyLoadingState());
      final company = await companyRepository.getCompany();
      company.fold((failure) {
        emit(CompanyErrorState(errorMessage: failure.message));
      }, (company) {
        emit(
          CompanyLoadedState(company: company),
        );
      });
    });
    on<AddCompanyEvent>((event, emit) async {
      emit(CompanyLoadingState());
      final uploadImage = await storageFileRepository.uploadFile(
          event.xFileEntities, FireBaseCollection.companies);
      await uploadImage.fold((failure) {
        emit(CompanyErrorState(errorMessage: failure.message));
      }, (r) async {
        final company = await companyRepository.addCompany(
          event.companyFullName,
          event.docName,
        );
        company.fold(
          (failure) {
            emit(CompanyErrorState(errorMessage: failure.message));
          },
          (r) {
            emit(CompanyAddedSuccessfully());
          },
        );
      });
    });
    on<DeleteCompanyEvent>((event, emit) async {
      emit(CompanyDeleteLoadingState());
      final company = await companyRepository.deleteCompany(
        event.companyFullName,
        event.companyName,
      );
      company.fold((failure) {
        emit(DeleteCompanyErrorState(errorMessage: failure.message));
      }, (r) {
        emit(CompanyDeletedSuccessfully());
      });
    });
    on<EditCompanyEvent>((event, emit) async {
      emit(CompanyLoadingState());
      (await companyRepository.updateCompanyRanking(
              event.companyName, event.newRanking, event.oldRanking))
          .fold((failure) {
        emit(CompanyErrorState(errorMessage: failure.message));
      }, (r) {
        emit(CompanyEditSuccessfully());
      });
    });
  }
}
