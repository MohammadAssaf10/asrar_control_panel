import 'package:asrar_control_panel/features/home/domain/repositories/image_repository.dart';
import 'package:asrar_control_panel/features/home/domain/use_cases/get_file.dart';
import 'package:asrar_control_panel/features/home/presentation/manager/photo_gallery_bloc/gallery_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/home/data/repositories/image_repository_impl.dart';
import '../network/network_info.dart';

final GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared pref instance
  final sharedPref = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPref);

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  instance
      .registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  instance.registerLazySingleton<ImageRepository>(() => ImageRepositoryImpl(
      storage: instance<FirebaseStorage>(),
      networkInfo: instance<NetworkInfo>()));
  instance.registerLazySingleton<GetFileUseCase>(
      () => GetFileUseCase(instance<ImageRepository>()));
  instance.registerLazySingleton<GalleryBloc>(
      () => GalleryBloc(getFileUseCase: instance<GetFileUseCase>()));
}
