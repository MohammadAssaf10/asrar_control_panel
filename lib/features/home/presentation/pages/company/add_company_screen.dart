import 'dart:io';

import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../domain/entities/xfile_entities.dart';
import '../../../domain/use_cases/select_image_for_web.dart';
import '../../blocs/company/company_bloc.dart';
import '../../widgets/control_panel_button.dart';
import '../../widgets/input_field.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({Key? key}) : super(key: key);

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final SelectImageForWebUseCase selectImageForWebUseCase =
      SelectImageForWebUseCase();
  Uint8List webImage = Uint8List(8);
  late XFileEntities xFileEntities;
  File? image;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyBloc, CompanyState>(
      listener: (context, state) {
        if (state is CompanyLoadingState) {
          showCustomDialog(context);
        } else if (state is CompanyErrorState) {
          showCustomDialog(context, message: state.errorMessage);
        } else if (state is CompanyAddedSuccessfully) {
          showCustomDialog(context,
              message: AppStrings.addedSuccessfully.tr(context));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.addServicesCompany.tr(context)),
        ),
        body: Center(
          child: Container(
            width: AppSize.s200.w,
            height: AppSize.s550.h,
            color: ColorManager.white,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image == null
                        ? Padding(
                            padding: EdgeInsets.only(bottom: AppSize.s20.h),
                            child: Text(
                              AppStrings.pleaseSelectImage.tr(context),
                              style: getAlmaraiRegularStyle(
                                  fontSize: AppSize.s20.sp,
                                  color: ColorManager.primary),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSize.s10.w,
                              vertical: AppSize.s10.h,
                            ),
                            child: Image.memory(
                              webImage,
                              height: AppSize.s250.h,
                            ),
                          ),
                    InputField(
                      controller: _controller,
                      labelAndHintText: AppStrings.companyName.tr(context),
                      regExp: getTextWithNumberInputFormat(),
                      height: AppSize.s50.h,
                    ),
                    SizedBox(height: AppSize.s20.h),
                    ControlPanelButton(
                      buttonTitle: AppStrings.selectImage.tr(context),
                      onTap: () async {
                        xFileEntities = (await selectImageForWebUseCase())!;
                        setState(() {
                          webImage = xFileEntities.xFileAsBytes;
                          image = File(xFileEntities.name);
                        });
                      },
                    ),
                    ControlPanelButton(
                      buttonTitle: AppStrings.add.tr(context),
                      onTap: () {
                        if (image != null &&
                            _controller.text != "" &&
                            _controller.text.isNotEmpty &&
                            webImage.isNotEmpty) {
                          BlocProvider.of<CompanyBloc>(context)
                              .add(AddCompanyEvent(
                            companyFullName: image!.path,
                            docName: _controller.text,
                            xFileEntities: xFileEntities,
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
        ),
      ),
    );
  }
}
