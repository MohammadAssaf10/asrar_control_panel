// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../core/app/di.dart';
// import '../features/auth/data/data_sources/auth_prefs.dart';
import '../features/auth/presentation/bloc/authentication_bloc.dart';
import '../features/auth/presentation/pages/login_view.dart';

import '../features/employees_manager/presentation/employee_management/employee_management_bloc.dart';
import '../features/employees_manager/presentation/employee_management/employee_management_view.dart';
import '../features/home/domain/entities/company.dart';
import '../features/home/presentation/pages/add_ad_image_screen.dart';
import '../features/home/presentation/pages/add_company_screen.dart';
import '../features/home/presentation/pages/add_product_screen.dart';
import '../features/home/presentation/pages/add_services_screen.dart';
import '../features/home/presentation/pages/delete_company_screen.dart';
import '../features/home/presentation/pages/delete_service_screen.dart';
import '../features/home/presentation/pages/home_screen.dart';
import '../features/home/presentation/pages/photo_gallery_screen.dart';
import '../features/home/presentation/pages/products_screen.dart';
import '../features/home/presentation/pages/services_screen.dart';
import '../features/home/presentation/pages/shop_screen.dart';
import '../features/home/presentation/pages/update_company_ranking_screen.dart';
import '../splash.dart';
import 'strings_manager.dart';

class Routes {
  // home route
  static const String splashRoute = "/";
  static const String homeRoute = "/home";

  static const String addAnAdvertisementImageRoute = "/addAnAdvertisementImage";
  static const String photoGalleryRoute = "/photoGallery";
  static const String servicesRoute = "/services";
  static const String addCompanyRoute = "/addCompany";
  static const String addServicesRoute = "/addServices";
  static const String deleteCompanyRoute = "/deleteCompany";
  static const String deleteServiceRoute = "/deleteService";
  static const String shopRoute = "/shop";
  static const String addProductRoute = "/addProduct";
  static const String productsRoute = "/products";
  static const String updateCompanyRankingRouter = "/updateCompanyRanking";

  // employee manager routes
  static const String employeeList = "/employeeList";

  // auth rotes
  static const String loginRoute = '/login';
}

class RouteGenerator {
  // static final AuthPreferences _authPreferences = instance<AuthPreferences>();
  // static final AuthenticationBloc _authenticationBloc =
  //     AuthenticationBloc.instance;

  static Route getRoute(RouteSettings settings) {
    // todo: uncomment this after done developing
    // check if user logged in
    // if(_authenticationBloc.state is! AuthenticationSuccess){
    //   return MaterialPageRoute(builder: (_) => const LoginView());
    // }

    switch (settings.name) {

      // home route
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case Routes.homeRoute:
        // if (_authPreferences.canWork())
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      // continue de;

      // auth rotes
      case Routes.loginRoute:
        // todo: delete this line after add a logout button
        AuthenticationBloc.instance.add(LogOut());
        return MaterialPageRoute(builder: (_) => const LoginView());

      // employee manager routes
      case Routes.employeeList:
        // if (_authPreferences.employeeManagement())
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      EmployeeManagementBloc()..add(FetchEmployeesList()),
                  child: const EmployeeManagementView(),
                ));

      // continue de;

      //
      case Routes.addAnAdvertisementImageRoute:
        return MaterialPageRoute(builder: (_) => const AddAdImageScreen());
      case Routes.shopRoute:
        return MaterialPageRoute(builder: (_) => const ShopScreen());
      case Routes.addProductRoute:
        return MaterialPageRoute(builder: (_) => const AddProductScreen());
      case Routes.productsRoute:
        return MaterialPageRoute(builder: (_) => const ProductScreen());

      case Routes.photoGalleryRoute:
        return MaterialPageRoute(builder: (_) => const PhotoGalleryScreen());

      case Routes.servicesRoute:
        return MaterialPageRoute(builder: (_) => const ServicesScreen());

      case Routes.deleteCompanyRoute:
        return MaterialPageRoute(builder: (_) => const DeleteCompanyScreen());
      case Routes.deleteServiceRoute:
        return MaterialPageRoute(builder: (_) => const DeleteServiceScreen());
      case Routes.updateCompanyRankingRouter:
        {
          final arg = settings.arguments as CompanyEntities;
          return MaterialPageRoute(
              builder: (_) => UpdateCompanyRankingScreen(arg));
        }
      case Routes.addCompanyRoute:
        return MaterialPageRoute(builder: (_) => const AddCompanyScreen());

      case Routes.addServicesRoute:
        return MaterialPageRoute(builder: (_) => const AddServicesScreen());
      //de:
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
