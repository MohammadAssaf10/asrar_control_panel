// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

// import '../core/app/di.dart';
// import '../features/auth/data/data_sources/auth_prefs.dart';
import '../features/auth/presentation/bloc/authentication_bloc.dart';
import '../features/auth/presentation/pages/login_view.dart';
import '../features/employees_manager/presentation/page/employee_management_view.dart';
import '../features/home/domain/entities/company.dart';
import '../features/home/domain/entities/shop_order_entities.dart';
import '../features/home/presentation/pages/about_us/about_us_screen.dart';
import '../features/home/presentation/pages/about_us/add_about_us_screen.dart';
import '../features/home/presentation/pages/about_us/update_about_us_screen.dart';
import '../features/home/presentation/pages/ad/add_ad_Image_screen.dart';
import '../features/home/presentation/pages/ad/photo_gallery_screen.dart';
import '../features/home/presentation/pages/company/add_company_screen.dart';
import '../features/home/presentation/pages/company/delete_company_screen.dart';
import '../features/home/presentation/pages/company/update_company_ranking_screen.dart';
import '../features/home/presentation/pages/courses/add_courses_screen.dart';
import '../features/home/presentation/pages/courses/courses_screen.dart';
import '../features/home/presentation/pages/courses/delete_courses_screen.dart';
import '../features/employees_manager/presentation/page/employee_request_screen.dart';
import '../features/home/presentation/pages/home_screen.dart';
import '../features/home/presentation/pages/job/add_job_screen.dart';
import '../features/home/presentation/pages/job/delete_job_screen.dart';
import '../features/home/presentation/pages/job/job_screen.dart';
import '../features/home/presentation/pages/news/add_news_screen.dart';
import '../features/home/presentation/pages/news/delete_news_screen.dart';
import '../features/home/presentation/pages/news/news_screen.dart';
import '../features/home/presentation/pages/order/shop_order_details_screen.dart';
import '../features/home/presentation/pages/service/add_services_screen.dart';
import '../features/home/presentation/pages/service/delete_service_screen.dart';
import '../features/home/presentation/pages/service/services_screen.dart';
import '../features/home/presentation/pages/shop/add_product_screen.dart';
import '../features/home/presentation/pages/shop/products_screen.dart';
import '../features/home/presentation/pages/order/shop_order_screen.dart';
import '../features/home/presentation/pages/shop/shop_screen.dart';
import '../features/home/presentation/pages/subscription/add_subscription_sceen.dart';
import '../features/home/presentation/pages/subscription/delete_subscription_screen.dart';
import '../features/home/presentation/pages/subscription/subscription_screen.dart';
import '../features/home/presentation/pages/term_of_use/add_terms_of_use_screen.dart';
import '../features/home/presentation/pages/term_of_use/terms_of_use_screen.dart';
import '../features/home/presentation/pages/term_of_use/update_terms_of_use_screen.dart';
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
  static const String updateCompanyRankingRoute = "/updateCompanyRanking";
  static const String newsRoute = "/news";
  static const String addNewsRoute = "/addNews";
  static const String deleteNewsRoute = "/deleteNews";
  static const String coursesRoute = "/courses";
  static const String addCoursesRoute = "/addCourses";
  static const String deleteCoursesRoute = "/deleteCourses";
  static const String jobRoute = "/job";
  static const String addJobRoute = "/addJob";
  static const String deleteJobRoute = "/deleteJob";
  static const String subscriptionRoute = "/subscription";
  static const String addSubscriptionRoute = "/addSubscription";
  static const String deleteSubscriptionRoute = "/deleteSubscription";
  static const String shopOrderRoute = "/shopOrder";
  static const String shopOrderDetailsRoute = "/shopOrderDetails";
  static const String aboutUsRoute = "/aboutUs";
  static const String addAboutUsRoute = "/addAboutUs";
  static const String updateAboutUsRoute = "/updateAboutUs";
  static const String termsOfUseRoute = "/termsOfUse";
  static const String addTermsOfUseRoute = "/addTermsOfUse";
  static const String updateTermsOfUseRoute = "/updateTermsOfUse";
  static const String employeeRequestRoute = "/employeeRequest";

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
          builder: (_) => const EmployeeManagementView(),
        );

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
      case Routes.newsRoute:
        return MaterialPageRoute(builder: (_) => const NewsScreen());
      case Routes.addNewsRoute:
        return MaterialPageRoute(builder: (_) => const AddNewsScreen());
      case Routes.deleteNewsRoute:
        return MaterialPageRoute(builder: (_) => const DeleteNewsScreen());
      case Routes.coursesRoute:
        return MaterialPageRoute(builder: (_) => const CoursesScreen());
      case Routes.addCoursesRoute:
        return MaterialPageRoute(builder: (_) => const AddCoursesScreen());
      case Routes.deleteCoursesRoute:
        return MaterialPageRoute(builder: (_) => const DeleteCoursesScreen());
      case Routes.shopOrderRoute:
        return MaterialPageRoute(builder: (_) => const ShopOrderScreen());
      case Routes.shopOrderDetailsRoute:
        {
          final arg = settings.arguments as ShopOrderEntities;
          return MaterialPageRoute(
            builder: (_) => ShopOrderDetailsScreen(arg),
          );
        }
      case Routes.jobRoute:
        return MaterialPageRoute(builder: (_) => const JobScreen());
      case Routes.addJobRoute:
        return MaterialPageRoute(builder: (_) => const AddJobScreen());
      case Routes.deleteJobRoute:
        return MaterialPageRoute(builder: (_) => const DeleteJobScreen());
      case Routes.subscriptionRoute:
        return MaterialPageRoute(builder: (_) => const SubscriptionScreen());
      case Routes.addSubscriptionRoute:
        return MaterialPageRoute(builder: (_) => const AddSubscriptionScreen());
      case Routes.deleteSubscriptionRoute:
        return MaterialPageRoute(
            builder: (_) => const DeleteSubscriptionScreen());
      case Routes.photoGalleryRoute:
        return MaterialPageRoute(builder: (_) => const PhotoGalleryScreen());
      case Routes.servicesRoute:
        return MaterialPageRoute(builder: (_) => const ServicesScreen());
      case Routes.deleteCompanyRoute:
        return MaterialPageRoute(builder: (_) => const DeleteCompanyScreen());
      case Routes.deleteServiceRoute:
        return MaterialPageRoute(builder: (_) => const DeleteServiceScreen());
      case Routes.updateCompanyRankingRoute:
        {
          final arg = settings.arguments as CompanyEntities;
          return MaterialPageRoute(
            builder: (_) => UpdateCompanyRankingScreen(arg),
          );
        }
      case Routes.addCompanyRoute:
        return MaterialPageRoute(builder: (_) => const AddCompanyScreen());
      case Routes.aboutUsRoute:
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());
      case Routes.addAboutUsRoute:
        return MaterialPageRoute(builder: (_) => const AddAboutUsScreen());
      case Routes.updateAboutUsRoute:
        return MaterialPageRoute(builder: (_) => const UpdateAboutUsScreen());
      case Routes.termsOfUseRoute:
        return MaterialPageRoute(builder: (_) => const TermsOfUseScreen());
      case Routes.addTermsOfUseRoute:
        return MaterialPageRoute(builder: (_) => const AddTermsOfUseScreen());
      case Routes.updateTermsOfUseRoute:
        return MaterialPageRoute(
            builder: (_) => const UpdateTermsOfUseScreen());
      case Routes.employeeRequestRoute:
        return MaterialPageRoute(builder: (_) => const EmployeeRequestScreen());

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
