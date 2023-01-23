import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../blocs/company/company_bloc.dart';
import '../blocs/services_bloc/services_bloc.dart';

class DeleteCompanyScreen extends StatelessWidget {
  const DeleteCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocListener<CompanyBloc, CompanyState>(
          listener: (context, state) {
            if (state is CompanyDeleteLoadingState) {
              showCustomDialog(context);
            } else if (state is DeleteCompanyErrorState) {
              showCustomDialog(context, message: state.errorMessage);
            } else if (state is CompanyDeletedSuccessfully) {
              showCustomDialog(context,
                  message: AppStrings.deletedSuccessfully.tr(context));
              BlocProvider.of<CompanyBloc>(context).add(GetCompanyEvent());
            }
          },
          child: BlocBuilder<CompanyBloc, CompanyState>(
            builder: (context, state) {
              if (state is CompanyLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                  ),
                );
              } else if (state is CompanyErrorState) {
                return Center(
                  child: Text(
                    state.errorMessage,
                    style: getAlmaraiRegularStyle(
                      fontSize: AppSize.s20.sp,
                      color: ColorManager.error,
                    ),
                  ),
                );
              } else if (state is CompanyLoadedState) {
                if (state.company.isNotEmpty) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.company.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            BlocProvider.of<ServicesBloc>(context)
                                .add(GetServicesEvent(
                              companyName: state.company[index].name,
                            ));
                            Navigator.pushNamed(
                                context, Routes.deleteServiceRoute);
                          },
                          child: Container(
                            height: AppSize.s50.h,
                            margin: EdgeInsets.symmetric(
                              vertical: AppSize.s10.h,
                              horizontal: AppSize.s120.w,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius:
                                  BorderRadius.circular(AppSize.s20.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    BlocProvider.of<CompanyBloc>(context)
                                        .add(DeleteCompany(
                                      companyFullName:
                                          state.company[index].fullName,
                                      companyName: state.company[index].name,
                                    ));
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppSize.s10.w),
                                  child: Text(
                                    state.company[index].name,
                                    style: getAlmaraiRegularStyle(
                                      fontSize: AppSize.s18.sp,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: Text(
                      AppStrings.noCompanies.tr(context),
                      style: getAlmaraiRegularStyle(
                        fontSize: AppSize.s25.sp,
                        color: ColorManager.primary,
                      ),
                    ),
                  );
                }
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
