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
import '../../widgets/error_view.dart';
import '../../widgets/input_field.dart';
import '../../widgets/loading_view.dart';

class UpdateTermsOfUseScreen extends StatelessWidget {
  const UpdateTermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
     TextEditingController termsOfUseController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<TermsOfUseBloc, TermsOfUseState>(listener: (context, state) {
        if (state.status == TermsOfUseStatus.updateLoading) {
          showCustomDialog(context);
        }
        if (state.status == TermsOfUseStatus.updateError) {
          showCustomDialog(context, message: state.errorMessage.tr(context));
          BlocProvider.of<TermsOfUseBloc>(context).add(
            GetTermsOfUseEvent(),
          );
        }
        if (state.status == TermsOfUseStatus.updated) {
          showCustomDialog(context,
              message: AppStrings.updatedSuccessfully.tr(context));
          BlocProvider.of<TermsOfUseBloc>(context).add(
            GetTermsOfUseEvent(),
          );
        }
      }, builder: (context, state) {
        if (state.status == TermsOfUseStatus.loading) {
          return LoadingView(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          );
        } else if (state.status == TermsOfUseStatus.error) {
          return ErrorView(
            errorMessage: state.errorMessage.tr(context),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          );
        } else if (state.status == TermsOfUseStatus.loaded) {
          termsOfUseController = TextEditingController(text: state.termsOfUse);
          return Center(
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
                    buttonTitle: AppStrings.updateTermsOfUse.tr(context),
                    onTap: () {
                      if (termsOfUseController.text.isNotEmpty) {
                        BlocProvider.of<TermsOfUseBloc>(context).add(
                            UpdateTermsOfUseEvent(
                                termsOfUse: termsOfUseController.text));
                      }
                    },
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}