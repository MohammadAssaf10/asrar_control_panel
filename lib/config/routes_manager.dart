import 'package:flutter/material.dart';

import '../features/home/presentation/pages/add_ad_Image_screen.dart';
import '../features/home/presentation/pages/add_services_company_screen.dart';
import '../features/home/presentation/pages/home_screen.dart';
import '../features/home/presentation/pages/photo_gallery_screen.dart';
import '../features/home/presentation/pages/services_screen.dart';
import 'strings_manager.dart';

class Routes {
  // home route
  static const String homeRoute = "/";
  static const String addAnAdvertisementImageRoute = "/addAnAdvertisementImage";
  static const String photoGalleryRoute = "/photoGallery";
  static const String servicesRoute = "/services";
  static const String addServicesCompanyRoute = "/addServicesCompany";

  // auth rotes
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String resetPassword = '/resetPassword';
}

class RouteGenerator {
  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.addAnAdvertisementImageRoute:
        return MaterialPageRoute(builder: (_) => const AddAdImageScreen());
      case Routes.photoGalleryRoute:
        return MaterialPageRoute(builder: (_) => const PhotoGalleryScreen());
      case Routes.servicesRoute:
        return MaterialPageRoute(builder: (_) => const ServicesScreen());
      case Routes.addServicesCompanyRoute:
        return MaterialPageRoute(builder: (_) => const AddServicesCompanyScreen());
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
