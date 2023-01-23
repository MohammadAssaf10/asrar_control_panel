
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_localizations.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/permissions.dart';
import 'employee_list_bloc.dart';

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocSelector<EmployeeListBloc, EmployeeListState, Status>(
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
          return BlocBuilder<EmployeeListBloc, EmployeeListState>(
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

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required employee,
  }) : _employee = employee;

  final Employee _employee;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => EmployeeDialog(
                  employee: _employee,
                  blocContext: context,
                ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: _getCardColor(_employee)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'email: ${_employee.email}',
                  style: TextStyle(color: _getCardColor(_employee)),
                ),
                Text('name: ${_employee.name}',
                    style: TextStyle(color: _getCardColor(_employee))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color _getCardColor(Employee employee) {
  if (employee.permissions.isRejected) return ColorManager.error;
  if (employee.permissions.canWork) return ColorManager.primary;
  return ColorManager.blue;
}

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
          child: BlocBuilder<EmployeeListBloc, EmployeeListState>(
            bloc: BlocProvider.of<EmployeeListBloc>(blocContext)
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
                                  '${AppStrings.mobileNumber.tr(context)}: ${_employee.phonNumber}'),
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
                                BlocProvider.of<EmployeeListBloc>(blocContext)
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

class EmployeeImages extends StatelessWidget {
  const EmployeeImages({
    Key? key,
    required this.state,
  }) : super(key: key);

  final EmployeeListState state;

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

/// [value] should have 8 item
class PermissionsList extends StatefulWidget {
  const PermissionsList(
      {super.key, required this.onChange, required this.permissions});

  final Permissions permissions;
  final Function(Permissions) onChange;

  @override
  State<PermissionsList> createState() => _PermissionsListState();
}

class _PermissionsListState extends State<PermissionsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PermissionCheckbox(
            permission: widget.permissions.isRejected,
            onChange: (value) {
              widget.permissions.isRejected = value;
              widget.onChange(widget.permissions);
            },
            permissionName: AppStrings.isRejected),
        PermissionCheckbox(
            permission: widget.permissions.canWork,
            onChange: (value) {
              widget.permissions.canWork = value;
              widget.onChange(widget.permissions);
            },
            permissionName: AppStrings.canWork),
        PermissionCheckbox(
            permission: widget.permissions.employeeManagement,
            onChange: (value) {
              widget.permissions.employeeManagement = value;
              widget.onChange(widget.permissions);
            },
            permissionName: AppStrings.employeeManagement),
        PermissionCheckbox(
            permission: widget.permissions.companyManagement,
            onChange: (value) {
              widget.permissions.companyManagement = value;
              widget.onChange(widget.permissions);
            },
            permissionName: AppStrings.companyManagement),
        PermissionCheckbox(
            permission: widget.permissions.technicalSupport,
            onChange: (value) {
              widget.permissions.technicalSupport = value;
              widget.onChange(widget.permissions);
            },
            permissionName: AppStrings.technicalSupport),
        PermissionCheckbox(
            permission: widget.permissions.addsManagement,
            onChange: (value) {
              widget.permissions.addsManagement = value;
              widget.onChange(widget.permissions);
            },
            permissionName: AppStrings.addsManagement),
        PermissionCheckbox(
            permission: widget.permissions.newsManagement,
            onChange: (value) {
              widget.permissions.newsManagement = value;
              widget.onChange(widget.permissions);
            },
            permissionName: AppStrings.newsManagement),
        PermissionCheckbox(
            permission: widget.permissions.offersManagement,
            onChange: (value) {
              widget.permissions.offersManagement = value;
              widget.onChange(widget.permissions);
            },
            permissionName: AppStrings.offersManagement),
        PermissionCheckbox(
            permission: widget.permissions.coursesManagement,
            onChange: (value) {
              widget.permissions.coursesManagement = value;
              widget.onChange(widget.permissions);
            },
            permissionName: AppStrings.coursesManagement),
      ],
    );
  }
}

class PermissionCheckbox extends StatefulWidget {
  const PermissionCheckbox(
      {super.key,
      required this.permission,
      required this.onChange,
      required this.permissionName});

  final bool permission;
  final String permissionName;
  final Function(bool) onChange;

  @override
  State<PermissionCheckbox> createState() => _PermissionCheckboxState();
}

class _PermissionCheckboxState extends State<PermissionCheckbox> {
  late bool permission;

  @override
  void initState() {
    permission = widget.permission;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: permission,
            onChanged: ((value) {
              setState(() {
                permission = value!;
              });
              widget.onChange(permission);
            })),
        Text(widget.permissionName.tr(context)),
      ],
    );
  }
}
