import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../widgets/control_panel_button.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
            body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ControlPanelButton(
            buttonTitle: AppStrings.addNews.tr(context),
            onTap: () {
              Navigator.pushNamed(context, Routes.addNewsRouter);
            },
          ),
          ControlPanelButton(
            buttonTitle: AppStrings.news.tr(context),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
