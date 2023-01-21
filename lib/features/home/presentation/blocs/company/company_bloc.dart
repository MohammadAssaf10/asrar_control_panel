import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        emit(CompanyErrorState(errorMessage: failure.message));
      }, (r) async {
        add(AddCompanyToStore(
            companyName: event.companyName, docName: event.docName));
      });
    });
    on<AddCompanyToStore>((event, emit) async {
      final company = await companyRepository.addCompany(
          "company", event.companyName, event.docName);
      company.fold(
        (failure) => emit(CompanyErrorState(errorMessage: failure.message)),
        (r) => emit(CompanyAddedSuccessfully()),
      );
    });
    on<DeleteCompany>((event, emit) async {
      emit(CompanyDeleteLoadingState());
      final company = await companyRepository.deleteCompany(event.companyName);
      company.fold(
          (failure) =>
              emit(DeleteCompanyErrorState(errorMessage: failure.message)),
          (r) => emit(CompanyDeletedSuccessfully()));
    });
  }
}
