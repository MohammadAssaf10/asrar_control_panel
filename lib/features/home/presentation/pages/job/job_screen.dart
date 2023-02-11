import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../blocs/job_bloc/job_bloc.dart';
import '../../widgets/control_panel_button.dart';

class JobScreen extends StatelessWidget {
  const JobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ControlPanelButton(
            buttonTitle: AppStrings.addJob.tr(context),
            onTap: () {
              Navigator.pushNamed(context, Routes.addJobRoute);
            },
          ),
          ControlPanelButton(
            buttonTitle: AppStrings.jobs.tr(context),
            onTap: () {
              BlocProvider.of<JobBloc>(context).add(
                GetJobsListEvent(),
              );
              Navigator.pushNamed(context, Routes.deleteJobRoute);
            },
          ),
        ],
      ),
    );
  }
}
