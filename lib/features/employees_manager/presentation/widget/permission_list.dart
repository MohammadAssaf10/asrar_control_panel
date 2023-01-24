import 'package:flutter/material.dart';

import '../../../../config/strings_manager.dart';
import '../../domain/entities/permissions.dart';
import 'permission_checkbox.dart';

class PermissionsList extends StatelessWidget {
  const PermissionsList(
      {super.key, required this.onChange, required this.permissions});

  final Permissions permissions;
  final Function(Permissions) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PermissionCheckbox(
            permission: permissions.isRejected,
            onChange: (value) {
              permissions.isRejected = value;
              onChange(permissions);
            },
            permissionName: AppStrings.isRejected),
        PermissionCheckbox(
            permission: permissions.canWork,
            onChange: (value) {
              permissions.canWork = value;
              onChange(permissions);
            },
            permissionName: AppStrings.canWork),
        PermissionCheckbox(
            permission: permissions.employeeManagement,
            onChange: (value) {
              permissions.employeeManagement = value;
              onChange(permissions);
            },
            permissionName: AppStrings.employeeManagement),
        PermissionCheckbox(
            permission: permissions.companyManagement,
            onChange: (value) {
              permissions.companyManagement = value;
              onChange(permissions);
            },
            permissionName: AppStrings.companyManagement),
        PermissionCheckbox(
            permission: permissions.technicalSupport,
            onChange: (value) {
              permissions.technicalSupport = value;
              onChange(permissions);
            },
            permissionName: AppStrings.technicalSupport),
        PermissionCheckbox(
            permission: permissions.addsManagement,
            onChange: (value) {
              permissions.addsManagement = value;
              onChange(permissions);
            },
            permissionName: AppStrings.addsManagement),
        PermissionCheckbox(
            permission: permissions.newsManagement,
            onChange: (value) {
              permissions.newsManagement = value;
              onChange(permissions);
            },
            permissionName: AppStrings.newsManagement),
        PermissionCheckbox(
            permission: permissions.offersManagement,
            onChange: (value) {
              permissions.offersManagement = value;
              onChange(permissions);
            },
            permissionName: AppStrings.offersManagement),
        PermissionCheckbox(
            permission: permissions.coursesManagement,
            onChange: (value) {
              permissions.coursesManagement = value;
              onChange(permissions);
            },
            permissionName: AppStrings.coursesManagement),
        PermissionCheckbox(
            permission: permissions.storeManagement,
            onChange: (value) {
              permissions.storeManagement = value;
              onChange(permissions);
            },
            permissionName: AppStrings.storeManagement),
      ],
    );
  }
}