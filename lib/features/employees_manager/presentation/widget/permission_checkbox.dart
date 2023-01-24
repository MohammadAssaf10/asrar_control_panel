import 'package:flutter/material.dart';

import '../../../../config/app_localizations.dart';

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
