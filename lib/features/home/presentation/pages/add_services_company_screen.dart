import 'dart:io';

import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/di.dart';
import '../../../../core/app/functions.dart';
import '../../domain/entities/xfile_entities.dart';
import '../../domain/repositories/file_repository.dart';
import '../../domain/use_cases/add_company.dart';
import '../../domain/use_cases/select_image_for_web.dart';
import '../../domain/use_cases/upload_file.dart';
import '../widgets/control_panel_button.dart';

class AddServicesCompanyScreen extends StatefulWidget {
  const AddServicesCompanyScreen({Key? key}) : super(key: key);

  @override
  State<AddServicesCompanyScreen> createState() =>
      _AddServicesCompanyScreenState();
}

class _AddServicesCompanyScreenState extends State<AddServicesCompanyScreen> {
  final SelectImageForWebUseCase selectImageForWebUseCase =
      SelectImageForWebUseCase();
  final UploadFileUseCase uploadFileUseCase =
      UploadFileUseCase(instance<FileRepository>());
  final AddCompanyUseCase addCompanyUseCase = AddCompanyUseCase();
  final TextEditingController _controller = TextEditingController();
  Uint8List webImage = Uint8List(8);
  late XFileEntities xFileEntities;
  File? image;

  @override
  Widget build(BuildContext context) {
    bool isTrue = _controller.text.isNotEmpty && image != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addServicesCompany.tr(context)),
      ),
      body: Center(
        child: Container(
          width: AppSize.s250.w,
          height: AppSize.s500.h,
          color: ColorManager.white,
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
              Container(
                width: AppSize.s120.w,
                height: AppSize.s40.h,
                decoration: BoxDecoration(
                    color: ColorManager.lightGrey,
                    borderRadius: BorderRadius.circular(AppSize.s10.r)),
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "اسم الشركة",
                  ),
                ),
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
                onTap: (isTrue
                    ? () async {
                        try {
                          final isUploaded = await uploadFileUseCase(
                              webImage, image!.path, "company");
                          isUploaded.fold((failure) {}, (r) async {
                            showCustomDialog(context);
                            r.whenComplete(() async {
                              final company = await addCompanyUseCase(
                                  "company", image!.path, _controller.text);
                              company.fold((l) {
                                dismissDialog(context);
                                showCustomDialog(context, message: l.message);
                              }, (r) {
                                dismissDialog(context);
                                showCustomDialog(context,
                                    message: AppStrings.addedSuccessfully
                                        .tr(context));
                              });
                            });
                          });
                        } catch (e) {
                          dismissDialog(context);
                          showCustomDialog(context, message: e.toString());
                        }
                      }
                    : () {
                        dismissDialog(context);
                        showCustomDialog(
                          context,
                          message: AppStrings.pleaseSelectImage.tr(context),
                        );
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
