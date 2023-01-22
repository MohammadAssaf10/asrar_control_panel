import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/presentation/pages/login_view.dart';
import '../features/employees_manager/presentation/employee_list/employee_list_bloc.dart';
import '../features/employees_manager/presentation/employee_list/employee_list_view.dart';
import '../features/home/presentation/pages/add_ad_image_screen.dart';
import '../features/home/presentation/pages/add_services_company_screen.dart';
import '../features/home/presentation/pages/add_services_screen.dart';
import '../features/home/presentation/pages/home_screen.dart';
import '../features/home/presentation/pages/photo_gallery_screen.dart';
import '../features/home/presentation/pages/services_screen.dart';
import '../splash.dart';
import 'strings_manager.dart';

class Routes {
  // home route
  static const String splashRoute = "/";
  static const String homeRoute = "/home";

  static const String addAnAdvertisementImageRoute = "/addAnAdvertisementImage";
  static const String photoGalleryRoute = "/photoGallery";
  static const String servicesRoute = "/services";
  static const String addServicesCompanyRoute = "/addServicesCompany";
  static const String addServicesRoute = "/addServices";

  // employee manager routes
  static const String employeeList = "/employeeList";

  // auth rotes
  static const String loginRoute = '/login';
}

class RouteGenerator {
  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {

      // home route
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      // auth rotes
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());

      // employee manager routes
      case Routes.employeeList:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => EmployeeListBloc()..add(FetchEmployeesList()),
                  child: const EmployeeListView(),
                ));

      //
      case Routes.addAnAdvertisementImageRoute:
        return MaterialPageRoute(builder: (_) => const AddAdImageScreen());

      case Routes.photoGalleryRoute:
        return MaterialPageRoute(builder: (_) => const PhotoGalleryScreen());

      case Routes.servicesRoute:
        return MaterialPageRoute(builder: (_) => const ServicesScreen());

      case Routes.addServicesCompanyRoute:
        return MaterialPageRoute(
            builder: (_) => const AddServicesCompanyScreen());

      case Routes.addServicesRoute:
        return MaterialPageRoute(builder: (_) => const AddServicesScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.noRouteFound,
          ),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
