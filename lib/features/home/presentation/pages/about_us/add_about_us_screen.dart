import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../blocs/about_us_bloc/about_us_bloc.dart';
import '../../widgets/control_panel_button.dart';
import '../../widgets/input_field.dart';

class AddAboutUsScreen extends StatelessWidget {
  const AddAboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController aboutUsController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AboutUsBloc, AboutUsState>(
        listener: (context, state) {
          if (state.status == AboutUsStatus.loading) {
            showCustomDialog(context);
          }
          if (state.status == AboutUsStatus.error) {
            showCustomDialog(context, message: state.errorMessage.tr(context));
          }
          if (state.status == AboutUsStatus.added) {
            showCustomDialog(context,
                message: AppStrings.addedSuccessfully.tr(context));
          }
        },
        child: Center(
          child: Container(
            width: AppSize.s200.w,
            height: AppSize.s550.h,
            color: ColorManager.white,
            child: Column(
              children: [
                InputField(
                  controller: aboutUsController,
                  labelText: AppStrings.aboutUs.tr(context),
                  regExp: getAllKeyboradInputFormat(),
                  height: AppSize.s400.h,
                  width: AppSize.s190.w,
                ),
                ControlPanelButton(
                  buttonTitle: AppStrings.add.tr(context),
                  onTap: () {
                    if (aboutUsController.text.isNotEmpty) {
                      BlocProvider.of<AboutUsBloc>(context).add(
                          AddAbuotUsEvent(aboutUs: aboutUsController.text));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
