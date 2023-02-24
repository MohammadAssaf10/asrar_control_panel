import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../blocs/about_us_bloc/about_us_bloc.dart';
import '../../widgets/control_panel_button.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ControlPanelButton(
            buttonTitle: AppStrings.addAboutUs.tr(context),
            onTap: () {
              Navigator.pushNamed(context, Routes.addAboutUsRoute);
            },
          ),
          ControlPanelButton(
            buttonTitle: AppStrings.updateAboutUs.tr(context),
            onTap: () {
              BlocProvider.of<AboutUsBloc>(context).add(
                GetAbuotUsEvent(),
              );
              Navigator.pushNamed(context, Routes.updateAboutUsRoute);
            },
          ),
        ],
      ),
    );
  }
}
