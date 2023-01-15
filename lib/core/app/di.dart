import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/home/data/repositories/company_repository_impl.dart';
import '../../features/home/data/repositories/service_repository_impl.dart';
import '../../features/home/data/repositories/storage_file_repository_impl.dart';
import '../../features/home/domain/repositories/company_repository.dart';
import '../../features/home/domain/repositories/service_repository.dart';
import '../../features/home/domain/repositories/storage_file_repository.dart';
import '../../features/home/domain/use_cases/add_service.dart';
import '../../features/home/domain/use_cases/get_company.dart';
import '../../features/home/domain/use_cases/get_storage_file.dart';

final GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared pref instance
  final sharedPref = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPref);
  instance.registerLazySingleton<StorageFileRepository>(
      () => StorageFileRepositoryImpl(
            storage: FirebaseStorage.instance,
          ));
  instance.registerLazySingleton<GetStorageFileUseCase>(() =>
      GetStorageFileUseCase(
          imageRepository: instance<StorageFileRepository>()));
  instance.registerLazySingleton<CompanyRepository>(
      () => CompanyRepositoryImpl(db: FirebaseFirestore.instance));
  instance.registerLazySingleton<GetCompanyUseCase>(() =>
      GetCompanyUseCase(companyRepository: instance<CompanyRepository>()));
  instance
      .registerLazySingleton<ServiceRepository>(() => ServiceRepositoryImpl());
  instance.registerLazySingleton<AddServiceUseCase>(() =>
      AddServiceUseCase(serviceRepository: instance<ServiceRepository>()));
}
