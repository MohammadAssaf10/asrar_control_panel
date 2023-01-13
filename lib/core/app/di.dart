import 'package:asrar_control_panel/features/home/domain/repositories/file_repository.dart';
import 'package:asrar_control_panel/features/home/domain/use_cases/get_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/home/data/repositories/file_repository_impl.dart';

final GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared pref instance
  final sharedPref = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPref);
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
