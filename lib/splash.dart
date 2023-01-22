import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes_manager.dart';
import 'language_cubit/language_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 500,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.loginRoute);
                },
                child: const Text('Auth')),
          ),
         
          SizedBox(
            width: 500,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.homeRoute);
                },
                child: const Text('home')),
          ),
          SizedBox(
            width: 500,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.addServicesCompanyRoute);
                },
                child: const Text('addServicesCompanyRoute')),
          ),
          SizedBox(
            width: 500,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.photoGalleryRoute);
                },
                child: const Text('photoGalleryRoute')),
          ),
          SizedBox(
            width: 500,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.employeeList);
                },
                child: const Text('employee list')),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      context.read<LanguageCubit>().setArabic();
                    },
                    child: const Text('ar')),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      context.read<LanguageCubit>().setEnglish();
                    },
                    child: const Text('en')),
              ),
            ],
          )
        ],
      )),
    );
  }
}
