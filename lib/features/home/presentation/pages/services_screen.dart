import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../widgets/control_panel_button.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.services.tr(context)),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              ControlPanelButton(
                  buttonTitle: AppStrings.addServicesCompany.tr(context),
                  onTap: () => Navigator.pushNamed(
                      context, Routes.addServicesCompanyRoute))
            ],
          ),
          Column(
            children: [
              ControlPanelButton(
                  buttonTitle: AppStrings.addServices.tr(context),
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.addServicesRoute))
            ],
          )
        ],
      ),
    );
  }
}
