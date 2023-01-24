import 'package:flutter/material.dart';

import '../../../../config/color_manager.dart';
import '../../domain/entities/employee.dart';
import 'employee_dialog.dart';

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