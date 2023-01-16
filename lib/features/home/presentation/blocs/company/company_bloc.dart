import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/company.dart';
import '../../../domain/entities/xfile_entities.dart';
import '../../../domain/repositories/company_repository.dart';
import '../../../domain/repositories/storage_file_repository.dart';
import '../../../domain/use_cases/add_company.dart';
import '../../../domain/use_cases/get_company.dart';
import '../../../domain/use_cases/upload_file_to_storage.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final GetCompanyUseCase getCompanyUseCase =
      GetCompanyUseCase(companyRepository: instance<CompanyRepository>());
  final AddCompanyUseCase addCompanyUseCase =
      AddCompanyUseCase(companyRepository: instance<CompanyRepository>());
  final UploadFileToStorageUseCase uploadFileUseCase =
      UploadFileToStorageUseCase(
          fileRepository: instance<StorageFileRepository>());

  CompanyBloc() : super(CompanyInitial()) {
    on<GetCompanyEvent>((event, emit) async {
      emit(CompanyLoadingState());
      final company = await getCompanyUseCase();
      company.fold(
        (failure) => emit(CompanyErrorState(errorMessage: failure.message)),
        (company) => emit(
          CompanyLoadedState(company: company),
        ),
      );
    });
    on<AddCompanyEvent>((event, emit) async {
      emit(CompanyLoadingState());
      final uploadImage =
          await uploadFileUseCase(event.xFileEntities, "company");
      uploadImage.fold(
          (failure) => emit(CompanyErrorState(errorMessage: failure.message)),
          (task) {
        task.whenComplete(() async {
          final company = await addCompanyUseCase(
              "company", event.companyName, event.docName);
          company.fold(
              (failure) =>
                  emit(CompanyErrorState(errorMessage: failure.message)),
              (r) => emit(CompanyAddedSuccessfully()));
        });
      });
    });
  }
}
