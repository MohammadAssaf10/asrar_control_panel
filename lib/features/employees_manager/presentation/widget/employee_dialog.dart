import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/app_localizations.dart';
import '../../../../config/strings_manager.dart';
import '../../domain/entities/employee.dart';

import '../employee_management_bloc/employee_management_bloc.dart';
import '../page/employee_management_view.dart';
import 'permission_list.dart';

class EmployeeDialog extends StatelessWidget {
  const EmployeeDialog({
    super.key,
    required employee,
    required this.blocContext,
  }) : _employee = employee;

  final Employee _employee;
  final BuildContext blocContext;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<EmployeeManagementBloc, EmployeeManagementState>(
            bloc: BlocProvider.of<EmployeeManagementBloc>(blocContext)
              ..add(FetchEmployeeImages(employee: _employee)),
            builder: (context, state) {
              return SingleChildScrollView(
                child: SizedBox(
                  width: 600,
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.person,
                            size: 100,
                            color: ColorManager.grey,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${AppStrings.name.tr(context)}: ${_employee.name}'),
                              Text(
                                  '${AppStrings.email.tr(context)}: ${_employee.email}'),
                              Text(
                                  '${AppStrings.idNumber.tr(context)}: ${_employee.idNumber}'),
                              Text(
                                  '${AppStrings.mobileNumber.tr(context)}: ${_employee.phoneNumber}'),
                              Text(
                                  '${AppStrings.nationality.tr(context)}: ${_employee.national}'),
                            ],
                          )
                        ],
                      ),
                      // ignore: prefer_const_literals_to_create_immutables
                      PermissionsList(
                        onChange: (v) {
                          // todo check if its work
                          _employee.permissions = v;
                          print('\x1B[33m$_employee');
                          print('\x1B[34m$_employee');
                        },
                        permissions: _employee.permissions,
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<EmployeeManagementBloc>(
                                        blocContext)
                                    .add(UpdateEmployee(employee: _employee));
                                Navigator.pop(context);
                              },
                              child: Text(AppStrings.save.tr(context)),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(AppStrings.cancel.tr(context))),
                          ],
                        ),
                      ),
                      if (state.employeeImageStatus == Status.success)
                        EmployeeImages(
                          state: state,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
