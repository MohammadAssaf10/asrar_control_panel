import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_localizations.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../../domain/entities/employee.dart';
import 'employee_list_bloc.dart';

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EmployeeListBloc, EmployeeListState>(
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
            border: Border.all(
                color:
                    ColorManager.primary),
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
                  style: const TextStyle(
                      color
                          : ColorManager.primary),
                ),
                Text('name: ${_employee.name}',
                    style: const TextStyle(
                        color
                            : ColorManager.primary)),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
                      PermissionsList(onChange: (v) {}, value: [
                        true,
                        true,
                        true,
                        true,
                        true,
                        true,
                        true,
                        true,
                      ]),
                      if (state.employeeImageStatus == Status.success)
                        ListView.builder(
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
                            }))
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

/// [value] should have 8 item
class PermissionsList extends StatefulWidget {
  const PermissionsList(
      {super.key, required this.onChange, required this.value});

  final List<bool> value;
  final Function(List<bool>) onChange;

  @override
  State<PermissionsList> createState() => _PermissionsListState();
}

class _PermissionsListState extends State<PermissionsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
                value: widget.value[0],
                onChanged: ((value) {
                  setState(() {
                    widget.value[0] = value!;
                  });
                  widget.onChange(widget.value);
                })),
            Text(AppStrings.canWork.tr(context)),
          ],
        ),
        Row(
          children: [
            Checkbox(
                value: widget.value[1],
                onChanged: ((value) {
                  setState(() {
                    widget.value[1] = value!;
                  });
                  widget.onChange(widget.value);
                })),
            Text(AppStrings.employeeManagement.tr(context)),
          ],
        ),
        Row(
          children: [
            Checkbox(
                value: widget.value[5],
                onChanged: ((value) {
                  setState(() {
                    widget.value[5] = value!;
                  });
                  widget.onChange(widget.value);
                })),
            Text(AppStrings.companyManagement.tr(context)),
          ],
        ),
        Row(
          children: [
            Checkbox(
                value: widget.value[2],
                onChanged: ((value) {
                  setState(() {
                    widget.value[2] = value!;
                  });
                  widget.onChange(widget.value);
                })),
            Text(AppStrings.newsManagement.tr(context)),
          ],
        ),
        Row(
          children: [
            Checkbox(
                value: widget.value[3],
                onChanged: ((value) {
                  setState(() {
                    widget.value[3] = value!;
                  });
                  widget.onChange(widget.value);
                })),
            Text(AppStrings.addsManagement.tr(context)),
          ],
        ),
        Row(
          children: [
            Checkbox(
                value: widget.value[4],
                onChanged: ((value) {
                  setState(() {
                    widget.value[4] = value!;
                  });
                  widget.onChange(widget.value);
                })),
            Text(AppStrings.offersManagement.tr(context)),
          ],
        ),
        Row(
          children: [
            Checkbox(
                value: widget.value[6],
                onChanged: ((value) {
                  setState(() {
                    widget.value[6] = value!;
                  });
                  widget.onChange(widget.value);
                })),
            Text(AppStrings.coursesManagement.tr(context)),
          ],
        ),
        Row(
          children: [
            Checkbox(
                value: widget.value[7],
                onChanged: ((value) {
                  setState(() {
                    widget.value[7] = value!;
                  });
                  widget.onChange(widget.value);
                })),
            Text(AppStrings.technicalSupport.tr(context)),
          ],
        ),
      ],
    );
  }
}
