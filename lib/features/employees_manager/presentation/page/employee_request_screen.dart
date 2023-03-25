import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../../../home/presentation/widgets/empty_list_view.dart';
import '../../../home/presentation/widgets/error_view.dart';
import '../../../home/presentation/widgets/image_network.dart';
import '../../../home/presentation/widgets/loading_view.dart';
import '../employee_management_bloc/employee_management_bloc.dart';
import '../../../home/presentation/widgets/table_subtitle.dart';
import '../../../home/presentation/widgets/table_title.dart';

class EmployeeRequestScreen extends StatelessWidget {
  const EmployeeRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.employeesRequests.tr(context),
        ),
      ),
      body: BlocConsumer<EmployeeManagementBloc, EmployeeManagementState>(
        listener: (context, state) {
          if (state.updateEmployeeStatus == Status.loading) {
            showCustomDialog(context);
          } else if (state.updateEmployeeStatus == Status.failed) {
            showCustomDialog(context, message: state.errorMessage.tr(context));
            BlocProvider.of<EmployeeManagementBloc>(context)
                .add(GetEmployeesRequests());
          } else if (state.updateEmployeeStatus == Status.success) {
            showCustomDialog(context,
                message: AppStrings.requestAccepted.tr(context));
            BlocProvider.of<EmployeeManagementBloc>(context)
                .add(GetEmployeesRequests());
          } else if (state.updateEmployeeStatus == Status.cancel) {
            showCustomDialog(context,
                message: AppStrings.requestCanceled.tr(context));
            BlocProvider.of<EmployeeManagementBloc>(context)
                .add(GetEmployeesRequests());
          }
        },
        builder: (context, state) {
          if (state.employeeRequestStatus == Status.loading) {
            return LoadingView(
              height: AppSize.s550.h,
              width: double.infinity,
            );
          } else if (state.employeeRequestStatus == Status.failed) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              height: AppSize.s550.h,
              width: double.infinity,
            );
          } else if (state.employeeRequestStatus == Status.success &&
              state.employeesRequestsList.isNotEmpty) {
            return Column(
              children: [
                Row(
                  children: [
                    //Name
                    TitleTable(title: AppStrings.oldName.tr(context)),
                    TitleTable(title: AppStrings.newName.tr(context)),
                    //Phone Number
                    TitleTable(title: AppStrings.oldPhoneNumber.tr(context)),
                    TitleTable(title: AppStrings.newPhoneNumber.tr(context)),
                    //Image
                    TitleTable(title: AppStrings.oldImage.tr(context)),
                    TitleTable(title: AppStrings.newImage.tr(context)),
                    //Options
                    TitleTable(title: AppStrings.options.tr(context)),
                  ],
                ),
                SizedBox(height: AppSize.s10.h),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.employeesRequestsList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: ColorManager.grey,
                        thickness: AppSize.s2.h,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          //Name
                          Expanded(
                            child: SubTitleTable(
                              subTitle: state.employeesRequestsList[index]
                                      .oldName.isEmpty
                                  ? '-'
                                  : state.employeesRequestsList[index].oldName,
                            ),
                          ),
                          Expanded(
                            child: SubTitleTable(
                              subTitle: state.employeesRequestsList[index]
                                      .newName.isEmpty
                                  ? '-'
                                  : state.employeesRequestsList[index].newName,
                            ),
                          ),
                          //Phone Number
                          Expanded(
                            child: SubTitleTable(
                              subTitle: state.employeesRequestsList[index]
                                      .oldPhoneNumber.isEmpty
                                  ? '-'
                                  : state.employeesRequestsList[index]
                                      .oldPhoneNumber,
                            ),
                          ),
                          Expanded(
                            child: SubTitleTable(
                              subTitle: state.employeesRequestsList[index]
                                      .newPhoneNumber.isEmpty
                                  ? '-'
                                  : state.employeesRequestsList[index]
                                      .newPhoneNumber,
                            ),
                          ),
                          //Image
                          Expanded(
                            child: state.employeesRequestsList[index]
                                    .oldImageURL.isEmpty
                                ? const SubTitleTable(subTitle: "-")
                                : ImageNetwork(
                                    image: state.employeesRequestsList[index]
                                        .oldImageURL,
                                    boxFit: BoxFit.fill,
                                    imageHeight: AppSize.s150.h,
                                    imageWidth: double.infinity,
                                    loadingHeight: AppSize.s150.h,
                                    loadingWidth: double.infinity,
                                  ),
                          ),
                          SizedBox(width: AppSize.s5.w),
                          Expanded(
                            child: state.employeesRequestsList[index]
                                    .newImageURL.isEmpty
                                ? const SubTitleTable(subTitle: "-")
                                : ImageNetwork(
                                    image: state.employeesRequestsList[index]
                                        .newImageURL,
                                    boxFit: BoxFit.fill,
                                    imageHeight: AppSize.s150.h,
                                    imageWidth: double.infinity,
                                    loadingHeight: AppSize.s150.h,
                                    loadingWidth: double.infinity,
                                  ),
                          ),
                          //Options
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    BlocProvider.of<EmployeeManagementBloc>(
                                            context)
                                        .add(AcceptEmployeeRequest(
                                            employeeRequest: state
                                                .employeesRequestsList[index]));
                                  },
                                  icon: const Icon(
                                    Icons.done,
                                    color: ColorManager.primary,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    BlocProvider.of<EmployeeManagementBloc>(
                                            context)
                                        .add(CancelEmployeeRequest(
                                            employeeId: state
                                                .employeesRequestsList[index]
                                                .employeeID,
                                            newImageName: state
                                                .employeesRequestsList[index]
                                                .newImageName));
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: ColorManager.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state.employeeRequestStatus == Status.success &&
              state.employeesRequestsList.isEmpty) {
            return EmptyListView(
              emptyListMessage: AppStrings.noOrder.tr(context),
              height: AppSize.s550.h,
              width: double.infinity,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
