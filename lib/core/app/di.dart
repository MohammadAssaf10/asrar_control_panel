import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/data_sources/auth_prefs.dart';
import '../../features/auth/data/repository/repository_impl.dart';
import '../../features/auth/domain/repository/repository.dart';

import '../../features/home/data/repositories/company_repository_impl.dart';
import '../../features/home/data/repositories/service_repository_impl.dart';
import '../../features/home/data/repositories/storage_file_repository_impl.dart';
import '../../features/home/domain/repositories/company_repository.dart';
import '../../features/home/domain/repositories/service_repository.dart';
import '../../features/home/domain/repositories/storage_file_repository.dart';

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
  instance
      .registerLazySingleton<CompanyRepository>(() => CompanyRepositoryImpl());

  // auth pref instance
  instance.registerLazySingleton<AuthPreferences>(
      () => AuthPreferences(instance<SharedPreferences>()));

  instance
      .registerLazySingleton<ServiceRepository>(() => ServiceRepositoryImpl());
}

void initAuthenticationModule() {
  if (!GetIt.I.isRegistered<Repository>()) {
    instance.registerLazySingleton<Repository>(() => RepositoryImp());
  }
}
