import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/data_sources/auth_prefs.dart';
import '../../features/auth/data/repository/firebase_auth_repository.dart';
import '../../features/auth/domain/repository/auth_repository.dart';

import '../../features/chat/data/repository/support_chat_repository_impl.dart';
import '../../features/chat/domain/repository/support_chat_repository.dart';
import '../../features/home/data/repositories/about_us_repository_impl.dart';
import '../../features/home/data/repositories/ad_image_repository_impl.dart';
import '../../features/home/data/repositories/company_repository_impl.dart';
import '../../features/home/data/repositories/course_repository_impl.dart';
import '../../features/home/data/repositories/job_repository_impl.dart';
import '../../features/home/data/repositories/news_repository_impl.dart';
import '../../features/home/data/repositories/service_repository_impl.dart';
import '../../features/home/data/repositories/shop_repository_impl.dart';
import '../../features/home/data/repositories/storage_file_repository_impl.dart';
import '../../features/home/data/repositories/subscription_repository_impl.dart';
import '../../features/home/data/repositories/terms_of_use_repository_impl.dart';
import '../../features/chat/domain/entities/message.dart';
import '../../features/home/domain/repositories/about_us_repository.dart';
import '../../features/home/domain/repositories/ad_image_repository.dart';
import '../../features/home/domain/repositories/company_repository.dart';
import '../../features/home/domain/repositories/course_repository.dart';
import '../../features/home/domain/repositories/job_repository.dart';
import '../../features/home/domain/repositories/news_repository.dart';
import '../../features/home/domain/repositories/shop_repository.dart';
import '../../features/home/domain/repositories/service_repository.dart';
import '../../features/home/domain/repositories/storage_file_repository.dart';
import '../../features/home/domain/repositories/subscription_repository.dart';
import '../../features/home/domain/repositories/terms_of_use_repository.dart';

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
  instance.registerLazySingleton<ShopRepository>(() => ShopRepositoryImpl());
  instance.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl());
  instance
      .registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl());
  instance
      .registerLazySingleton<AdImageRepository>(() => AdImageRepositoryImpl());
  instance.registerLazySingleton<JobRepository>(() => JobRepositoryImpl());
  instance.registerLazySingleton<SubscriptionRepository>(
      () => SubscriptionRepositoryImpl());
  instance
      .registerLazySingleton<AboutUsRepository>(() => AboutUsRepositoryImpl());
  instance.registerLazySingleton<TermsOfUseRepository>(
      () => TermsOfUseRepositoryImpl());
  instance.registerLazySingleton<SupportChatRepository>(
      () => SupportChatRepositoryImpl(firestore: FirebaseFirestore.instance));
}

void initAuthenticationModule() {
  if (!GetIt.I.isRegistered<AuthRepository>()) {
    instance
        .registerLazySingleton<AuthRepository>(() => FirebaseAuthRepository());
  }
}

void initSupportChatModule(Sender sender) {
  if (instance.isRegistered<SupportChatRepositoryImpl>()) {
    instance.unregister<SupportChatRepositoryImpl>();
  }
  instance.registerFactory<SupportChatRepositoryImpl>(() {
    return SupportChatRepositoryImpl(
        sender: sender, firestore: FirebaseFirestore.instance);
  });
}
