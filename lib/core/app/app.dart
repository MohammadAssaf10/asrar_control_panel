import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/app_localizations.dart';
import '../../config/routes_manager.dart';
import '../../config/theme_manager.dart';
import '../../features/auth/presentation/bloc/authentication_bloc.dart';
import '../../features/employees_manager/presentation/employee_management_bloc/employee_management_bloc.dart';
import '../../features/home/presentation/blocs/about_us_bloc/about_us_bloc.dart';
import '../../features/home/presentation/blocs/company/company_bloc.dart';
import '../../features/home/presentation/blocs/course_bloc/course_bloc.dart';
import '../../features/home/presentation/blocs/job_bloc/job_bloc.dart';
import '../../features/home/presentation/blocs/news_bloc/news_bloc.dart';
import '../../features/home/presentation/blocs/photo_gallery_bloc/ad_image_bloc.dart';
import '../../features/home/presentation/blocs/product/product_bloc.dart';
import '../../features/home/presentation/blocs/services_bloc/services_bloc.dart';
import '../../features/home/presentation/blocs/shop_order_bloc/shop_order_bloc.dart';
import '../../features/home/presentation/blocs/subscription_bloc/subscription_bloc.dart';
import '../../features/home/presentation/blocs/terms_of_use_bloc/terms_of_use_bloc.dart';
import '../../language_cubit/language_cubit.dart';
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
            BlocProvider<AdImageBloc>(
              create: (context) => AdImageBloc(),
            ),
            BlocProvider<CompanyBloc>(
              create: (context) => CompanyBloc(),
            ),
            BlocProvider<ProductBloc>(
              create: (context) => ProductBloc(),
            ),
            BlocProvider<NewsBloc>(
              create: (context) => NewsBloc(),
            ),
            BlocProvider<JobBloc>(
              create: (context) => JobBloc(),
            ),
            BlocProvider<ShopOrderBloc>(
              create: (context) => ShopOrderBloc(),
            ),
            BlocProvider<AboutUsBloc>(
              create: (context) => AboutUsBloc(),
            ),
            BlocProvider<TermsOfUseBloc>(
              create: (context) => TermsOfUseBloc(),
            ),
            BlocProvider<SubscriptionBloc>(
              create: (context) => SubscriptionBloc(),
            ),
            BlocProvider<CourseBloc>(
              create: (context) => CourseBloc(),
            ),
            BlocProvider<ServicesBloc>(
              create: (context) => ServicesBloc(),
            ),
            BlocProvider<EmployeeManagementBloc>(
              create: (context) => EmployeeManagementBloc(),
            ),
            BlocProvider<AuthenticationBloc>(
              lazy: false,
              create: ((context) =>
                  AuthenticationBloc.instance..add(AppStarted())),
            ),
            BlocProvider<LanguageCubit>(
              create: (context) => LanguageCubit(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "لوحة تحكم تطبيق أسرار",
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            supportedLocales: const [arabicLocale],
            locale: arabicLocale,
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
          ),
        );
      },
    );
  }
}
