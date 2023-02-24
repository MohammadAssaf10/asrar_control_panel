import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../blocs/terms_of_use_bloc/terms_of_use_bloc.dart';
import '../../widgets/control_panel_button.dart';
import '../../widgets/input_field.dart';

class AddTermsOfUseScreen extends StatelessWidget {
  const AddTermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController termsOfUseController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<TermsOfUseBloc, TermsOfUseState>(
        listener: (context, state) {
          if (state.status == TermsOfUseStatus.loading) {
            showCustomDialog(context);
          }
          if (state.status == TermsOfUseStatus.error) {
            showCustomDialog(context, message: state.errorMessage.tr(context));
          }
          if (state.status == TermsOfUseStatus.added) {
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
                  controller: termsOfUseController,
                  labelText: AppStrings.termsOfUse.tr(context),
                  regExp: getAllKeyboradInputFormat(),
                  height: AppSize.s400.h,
                  width: AppSize.s190.w,
                ),
                ControlPanelButton(
                  buttonTitle: AppStrings.add.tr(context),
                  onTap: () {
                    if (termsOfUseController.text.isNotEmpty) {
                      BlocProvider.of<TermsOfUseBloc>(context).add(
                          AddTermsOfUseEvent(
                              termsOfUse: termsOfUseController.text));
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
