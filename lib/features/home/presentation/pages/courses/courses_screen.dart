import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../blocs/course_bloc/course_bloc.dart';
import '../../widgets/control_panel_button.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ControlPanelButton(
            buttonTitle: AppStrings.addCourse.tr(context),
            onTap: () {
              Navigator.pushNamed(context, Routes.addCoursesRoute);
            },
          ),
          ControlPanelButton(
            buttonTitle: AppStrings.courses.tr(context),
            onTap: () {
              BlocProvider.of<CourseBloc>(context).add(
                GetCourseListEvent(),
              );
              Navigator.pushNamed(context, Routes.deleteCoursesRoute);
            },
          ),
        ],
      ),
    );
  }
}
