import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../widget/employee_card.dart';
import 'employee_management_bloc.dart';

class EmployeeManagementView extends StatelessWidget {
  const EmployeeManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
          BlocSelector<EmployeeManagementBloc, EmployeeManagementState, Status>(
        selector: (state) {
          return state.employeeListStatus;
        },
        builder: (context, state) {
          if (state == Status.loading) {
            showCustomDialog(context);
          }

          if (state == Status.success) {
            dismissDialog(context);
          }
          return BlocBuilder<EmployeeManagementBloc, EmployeeManagementState>(
            builder: (context, state) {
              print(state);
              if (state.employeeListStatus == Status.success) {
                return Center(
                  child: SizedBox(
                    width: AppSize.s600,
                    child: Card(
                      child: ListView.builder(
                          itemCount: state.employeeList.length,
                          itemBuilder: ((context, index) {
                            return EmployeeCard(
                                employee: state.employeeList[index]);
                          })),
                    ),
                  ),
                );
              }

              return Container();
            },
          );
        },
      ),
    );
  }
}

class EmployeeImages extends StatelessWidget {
  const EmployeeImages({
    Key? key,
    required this.state,
  }) : super(key: key);

  final EmployeeManagementState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.employeeImages.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(state.employeeImages[index].name),
                SizedBox(
                  height: 10.h,
                ),
                Image.network(
                  state.employeeImages[index].url,
                  width: 600.w,
                  height: 400.h,
                ),
              ],
            ),
          );
        }));
  }
}
