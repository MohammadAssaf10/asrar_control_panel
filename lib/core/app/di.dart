import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/data_sources/auth_prefs.dart';
import '../../features/auth/data/repository/firebase_auth_repository.dart';
import '../../features/auth/domain/repository/auth_repository.dart';

import '../../features/home/data/repositories/company_repository_impl.dart';
import '../../features/home/data/repositories/course_repository_impl.dart';
import '../../features/home/data/repositories/news_repository_impl.dart';
import '../../features/home/data/repositories/service_repository_impl.dart';
import '../../features/home/data/repositories/product_repository_impl.dart';
import '../../features/home/data/repositories/storage_file_repository_impl.dart';
import '../../features/home/domain/repositories/company_repository.dart';
import '../../features/home/domain/repositories/course_repository.dart';
import '../../features/home/domain/repositories/news_repository.dart';
import '../../features/home/domain/repositories/product_repository.dart';
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
  instance
      .registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
  instance.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl());
  instance
      .registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl());
}

void initAuthenticationModule() {
  if (!GetIt.I.isRegistered<AuthRepository>()) {
    instance
        .registerLazySingleton<AuthRepository>(() => FirebaseAuthRepository());
  }
}
