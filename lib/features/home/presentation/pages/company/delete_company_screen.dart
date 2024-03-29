import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../blocs/company/company_bloc.dart';
import '../../blocs/services_bloc/services_bloc.dart';
import '../../widgets/empty_list_view.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_view.dart';

class DeleteCompanyScreen extends StatelessWidget {
  const DeleteCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<CompanyBloc, CompanyState>(
        listener: (context, state) {
          if (state is CompanyDeleteLoadingState) {
            showCustomDialog(context);
          } else if (state is DeleteCompanyErrorState) {
            showCustomDialog(context, message: state.errorMessage);
          } else if (state is CompanyDeletedSuccessfully) {
            showCustomDialog(context,
                message: AppStrings.deletedSuccessfully.tr(context));
            BlocProvider.of<CompanyBloc>(context).add(GetCompaniesListEvent());
          }
        },
        child: BlocBuilder<CompanyBloc, CompanyState>(
          builder: (context, state) {
            if (state is CompanyLoadingState) {
              return LoadingView(
                height: AppSize.s550.h,
                width: double.infinity,
              );
            } else if (state is CompanyErrorState) {
              return ErrorView(
                errorMessage: state.errorMessage.tr(context),
                height: AppSize.s550.h,
                width: double.infinity,
              );
            } else if (state is CompanyLoadedState) {
              if (state.company.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.company.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<ServicesBloc>(context)
                                .add(GetServicesListEvent(
                              companyName: state.company[index].name,
                            ));
                            Navigator.pushNamed(
                                context, Routes.deleteServiceRoute);
                          },
                          child: Container(
                            height: AppSize.s50.h,
                            width: AppSize.s120.w,
                            margin: EdgeInsets.symmetric(
                              vertical: AppSize.s10.h,
                            ),
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius:
                                  BorderRadius.circular(AppSize.s10.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppSize.s8.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.company[index].name,
                                        style: getAlmaraiRegularStyle(
                                          fontSize: AppSize.s18.sp,
                                          color: ColorManager.white,
                                        ),
                                      ),
                                      Text(
                                        state.company[index].companyRanking
                                            .toString(),
                                        style: getAlmaraiRegularStyle(
                                          fontSize: AppSize.s18.sp,
                                          color: ColorManager.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        BlocProvider.of<CompanyBloc>(context)
                                            .add(DeleteCompanyEvent(
                                          companyFullName:
                                              state.company[index].fullName,
                                          companyName:
                                              state.company[index].name,
                                        ));
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context,
                                            Routes.updateCompanyRankingRoute,
                                            arguments: state.company[index]);
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return EmptyListView(
                  emptyListMessage: AppStrings.noCompanies.tr(context),
                  height: AppSize.s550.h,
                  width: double.infinity,
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
