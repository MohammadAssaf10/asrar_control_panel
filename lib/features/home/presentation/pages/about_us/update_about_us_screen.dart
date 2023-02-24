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
import '../../widgets/error_view.dart';
import '../../widgets/input_field.dart';
import '../../widgets/loading_view.dart';

class UpdateAboutUsScreen extends StatelessWidget {
  const UpdateAboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController aboutUsController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AboutUsBloc, AboutUsState>(listener: (context, state) {
        if (state.status == AboutUsStatus.updateLoading) {
          showCustomDialog(context);
        }
        if (state.status == AboutUsStatus.updateError) {
          showCustomDialog(context, message: state.errorMessage.tr(context));
          BlocProvider.of<AboutUsBloc>(context).add(
            GetAbuotUsEvent(),
          );
        }
        if (state.status == AboutUsStatus.updated) {
          showCustomDialog(context,
              message: AppStrings.updatedSuccessfully.tr(context));
          BlocProvider.of<AboutUsBloc>(context).add(
            GetAbuotUsEvent(),
          );
        }
      }, builder: (context, state) {
        if (state.status == AboutUsStatus.loading) {
          return LoadingView(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          );
        } else if (state.status == AboutUsStatus.error) {
          return ErrorView(
            errorMessage: state.errorMessage.tr(context),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          );
        } else if (state.status == AboutUsStatus.loaded) {
          aboutUsController = TextEditingController(text: state.aboutUs);
          return Center(
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
                    buttonTitle: AppStrings.updateAboutUs.tr(context),
                    onTap: () {
                      if (aboutUsController.text.isNotEmpty) {
                        BlocProvider.of<AboutUsBloc>(context).add(
                            UpdateAbuotUsEvent(
                                aboutUs: aboutUsController.text));
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
