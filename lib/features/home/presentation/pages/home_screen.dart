import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../widgets/control_panel_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.asrarControlPanel.tr(context)),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              ControlPanelButton(
                buttonTitle: AppStrings.addAnAdvertisementImage.tr(context),
                onTap: () => Navigator.pushNamed(
                    context, Routes.addAnAdvertisementImageRoute),
              ),
            ],
          ),
          Column(
            children: [
              ControlPanelButton(
                buttonTitle: AppStrings.services.tr(context),
                onTap: () =>
                    Navigator.pushNamed(context, Routes.servicesRoute),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
