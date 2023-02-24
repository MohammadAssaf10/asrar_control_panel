import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../domain/entities/company.dart';
import '../../blocs/company/company_bloc.dart';
import '../../widgets/control_panel_button.dart';
import '../../widgets/input_field.dart';

class UpdateCompanyRankingScreen extends StatelessWidget {
  const UpdateCompanyRankingScreen(this.company, {super.key});
  final CompanyEntities company;
  @override
  Widget build(BuildContext context) {
    TextEditingController companyRankingController = TextEditingController();
    companyRankingController =
        TextEditingController(text: company.companyRanking.toString());
    return BlocListener<CompanyBloc, CompanyState>(
      listener: (context, state) {
        if (state is CompanyLoadingState) {
          showCustomDialog(context);
        } else if (state is CompanyErrorState) {
          showCustomDialog(context, message: state.errorMessage.tr(context));
        } else if (state is CompanyEditSuccessfully) {
          showCustomDialog(context, message: "تم الحفظ");
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
            width: AppSize.s150.w,
            height: AppSize.s200.h,
            color: ColorManager.white,
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              children: [
                InputField(
                  controller: companyRankingController,
                  labelText: AppStrings.companyRanking.tr(context),
                  regExp: getNumberInputFormat(),
                  height: AppSize.s50.h,
                ),
                ControlPanelButton(
                  buttonTitle: AppStrings.save.tr(context),
                  onTap: () {
                    if (companyRankingController.text.isNotEmpty) {
                      BlocProvider.of<CompanyBloc>(context)
                          .add(EditCompanyEvent(
                        companyName: company.name,
                        newRanking: int.parse(companyRankingController.text),
                        oldRanking: company.companyRanking,
                      ));
                    } else {
                      showCustomDialog(context,
                          message: AppStrings.pleaseEnterAllRequiredData
                              .tr(context));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
