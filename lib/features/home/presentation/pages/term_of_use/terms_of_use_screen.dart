import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../blocs/terms_of_use_bloc/terms_of_use_bloc.dart';
import '../../widgets/control_panel_button.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ControlPanelButton(
            buttonTitle: AppStrings.addTermsOfUse.tr(context),
            onTap: () {
              Navigator.pushNamed(context, Routes.addTermsOfUseRoute);
            },
          ),
          ControlPanelButton(
            buttonTitle: AppStrings.updateTermsOfUse.tr(context),
            onTap: () {
              BlocProvider.of<TermsOfUseBloc>(context).add(
                GetTermsOfUseEvent(),
              );
              Navigator.pushNamed(context, Routes.updateTermsOfUseRoute);
            },
          ),
        ],
      ),
    );
  }
}
