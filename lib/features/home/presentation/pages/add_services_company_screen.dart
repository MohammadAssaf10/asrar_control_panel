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
import '../../domain/repositories/company_repository.dart';
import '../../domain/repositories/storage_file_repository.dart';
import '../../domain/use_cases/add_company.dart';
import '../../domain/use_cases/select_image_for_web.dart';
import '../../domain/use_cases/upload_file_to_storage.dart';
import '../widgets/control_panel_button.dart';
import '../widgets/input_field.dart';

class AddServicesCompanyScreen extends StatefulWidget {
  const AddServicesCompanyScreen({Key? key}) : super(key: key);

  @override
  State<AddServicesCompanyScreen> createState() =>
      _AddServicesCompanyScreenState();
}

class _AddServicesCompanyScreenState extends State<AddServicesCompanyScreen> {
  final SelectImageForWebUseCase selectImageForWebUseCase =
      SelectImageForWebUseCase();
  final UploadFileToStorageUseCase uploadFileUseCase =
      UploadFileToStorageUseCase(fileRepository:instance<StorageFileRepository>());
  final AddCompanyUseCase addCompanyUseCase =
      AddCompanyUseCase(companyRepository: instance<CompanyRepository>());
  Uint8List webImage = Uint8List(8);
  late XFileEntities xFileEntities;
  File? image;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addServicesCompany.tr(context)),
      ),
      body: Center(
        child: Container(
          width: AppSize.s200.w,
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
              InputField(
                widget: Text(
                  AppStrings.companyName.tr(context),
                  style: getAlmaraiRegularStyle(
                    fontSize: AppSize.s16.sp,
                    color: ColorManager.primary,
                  ),
                ),
                controller: _controller,
                hintTitle: AppStrings.companyName.tr(context),
                keyboardType: TextInputType.name,
                regExp: RegExp('[" "a-zأ-يA-Zا-ي]'),
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
                  onTap: () async {
                    try {
                      final isUploaded = await uploadFileUseCase(
                          webImage, image!.path, "company");
                      isUploaded.fold((failure) {
                        showCustomDialog(context);
                        showCustomDialog(context,
                            message: failure.message.tr(context));
                      }, (task) async {
                        showCustomDialog(context);
                        task.whenComplete(() async {
                          final company = await addCompanyUseCase(
                              "company", image!.path, _controller.text);
                          company.fold((failure) {
                            dismissDialog(context);
                            showCustomDialog(context, message: failure.message);
                          }, (r) {
                            dismissDialog(context);
                            showCustomDialog(context,
                                message:
                                    AppStrings.addedSuccessfully.tr(context));
                          });
                        });
                      });
                    } catch (e) {
                      dismissDialog(context);
                      showCustomDialog(context, message: e.toString());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
