import 'package:asrar_control_panel/features/home/domain/repositories/file_repository.dart';
import 'package:asrar_control_panel/features/home/domain/use_cases/get_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/data_sources/auth_prefs.dart';
import '../../features/auth/data/repository/repository_impl.dart';
import '../../features/auth/domain/repository/repository.dart';
import '../../features/home/domain/repositories/image_repository.dart';
import '../../features/home/domain/use_cases/get_file.dart';
import '../../features/home/presentation/manager/photo_gallery_bloc/gallery_bloc.dart';

final GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared pref instance
  final sharedPref = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPref);

  // auth pref instance
  instance.registerLazySingleton<AuthPreferences>(
      () => AuthPreferences(instance<SharedPreferences>()));

  instance
      .registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  instance.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  instance
      .registerLazySingleton<Reference>(() => FirebaseStorage.instance.ref());
  instance.registerLazySingleton<FileRepository>(() => FileRepositoryImpl(
        storage: instance<FirebaseStorage>(),
      ));
  instance.registerLazySingleton<GetFileUseCase>(
      () => GetFileUseCase(instance<FileRepository>()));
}

void initAuthenticationModule() {
  if (!GetIt.I.isRegistered<Repository>()) {
    instance.registerLazySingleton<Repository>(() => RepositoryImp());
  }
}

void initAuthenticationModule() {
  if (!GetIt.I.isRegistered<Repository>()) {
    instance.registerLazySingleton<Repository>(() => RepositoryImp());
  }
}
