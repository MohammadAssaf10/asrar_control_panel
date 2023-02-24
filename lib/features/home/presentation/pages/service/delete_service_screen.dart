import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../blocs/services_bloc/services_bloc.dart';
import '../../widgets/empty_list_view.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_view.dart';

class DeleteServiceScreen extends StatelessWidget {
  const DeleteServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<ServicesBloc, ServicesState>(
        listener: (context, state) {
          if (state is ServiceDeleteLoadingState) {
            showCustomDialog(context);
          } else if (state is DeleteServiceErrorState) {
            showCustomDialog(context, message: state.errorMessage);
          } else if (state is ServiceDeletedSuccessfully) {
            showCustomDialog(context,
                message: AppStrings.deletedSuccessfully.tr(context));
            BlocProvider.of<ServicesBloc>(context).add(
              GetServicesListEvent(companyName: state.companyName),
            );
          }
        },
        builder: (context, state) {
          if (state is ServiceLoadingState) {
            return LoadingView(
              height: AppSize.s550.h,
              width: double.infinity,
            );
          } else if (state is ServiceErrorState) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              height: AppSize.s550.h,
              width: double.infinity,
            );
          } else if (state is ServicesLoadedState) {
            if (state.services.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.services.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Container(
                      height: AppSize.s50.h,
                      width: AppSize.s120.w,
                      margin: EdgeInsets.symmetric(
                        vertical: AppSize.s10.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(AppSize.s10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: AppSize.s8.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.services[index].serviceName,
                                  style: getAlmaraiRegularStyle(
                                    fontSize: AppSize.s18.sp,
                                    color: ColorManager.white,
                                  ),
                                ),
                                Text(
                                  "${state.services[index].servicePrice} ر.س",
                                  textDirection: TextDirection.rtl,
                                  style: getAlmaraiRegularStyle(
                                    fontSize: AppSize.s16.sp,
                                    color: ColorManager.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<ServicesBloc>(context).add(
                                  DeleteServiceEvent(
                                      serviceName:
                                          state.services[index].serviceName,
                                      companyName:
                                          state.services[index].companyName));
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return EmptyListView(
                emptyListMessage: AppStrings.noServices.tr(context),
                height: AppSize.s550.h,
                width: double.infinity,
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
