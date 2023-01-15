import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../config/app_localizations.dart';
import '../../config/routes_manager.dart';
import '../../config/theme_manager.dart';
import '../../features/auth/presentation/bloc/authentication_bloc.dart';
import '../../features/home/domain/use_cases/get_storage_file.dart';
import '../../features/home/presentation/blocs/photo_gallery_bloc/gallery_bloc.dart';
import '../../language_cubit/language_cubit.dart';
import 'di.dart';
import 'language.dart';

class MyApp extends StatelessWidget {
  // named constructor
  const MyApp._internal();

  static const MyApp _instance =
      MyApp._internal(); // singleton or single instance

  factory MyApp() => _instance; // factory
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
             
            BlocProvider(
              create: (context) => GalleryBloc(getFileUseCase: instance<GetStorageFileUseCase>()),
            ),
            BlocProvider<AuthenticationBloc>(create: ((context) => AuthenticationBloc())),
            BlocProvider<LanguageCubit>(
              create: (context) => LanguageCubit(),
            ),
            BlocProvider(
                create: ((context) =>
                    GalleryBloc(getFileUseCase: instance<GetStorageFileUseCase>())))
          ],
          child: BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "لوحة تحكم تطبيق أسرار",
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  AppLocalizations.delegate,
                ],
                supportedLocales: const [arabicLocale, englishLocale],
                locale: state.locale,
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  for (var locale in supportedLocales) {
                    if (deviceLocale != null &&
                        deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                theme: getApplicationTheme(),
                onGenerateRoute: RouteGenerator.getRoute,
              );
            },
          ),
        );
      },
    );
  }
}
