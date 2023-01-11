import 'dart:io';

import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:asrar_control_panel/config/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/di.dart';
import '../../../../core/app/functions.dart';
import '../../domain/repositories/image_repository.dart';
import '../../domain/use_cases/upload_file.dart';
import '../manager/photo_gallery_bloc/gallery_bloc.dart';
import '../widgets/control_panel_button.dart';

class AddAdImageScreen extends StatefulWidget {
  const AddAdImageScreen({Key? key}) : super(key: key);

  @override
  State<AddAdImageScreen> createState() => _AddAdImageScreenState();
}

class _AddAdImageScreenState extends State<AddAdImageScreen> {
  final ImagePicker _picker = ImagePicker();
  File? image;
  XFile? imagePicked;

  void selectImage() async {
    // Pick an image
    imagePicked = await _picker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        image = File(imagePicked!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.addAnAdvertisementImage.tr(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
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
                      child: Image.network(
                        image!.path,
                        width: double.infinity,
                      ),
                    ),
              ControlPanelButton(
                buttonTitle: AppStrings.selectImage.tr(context),
                onTap: () => selectImage(),
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.uploadImage.tr(context),
                onTap: (imagePicked != null
                    ? () async {
                        final isLoaded = await UploadFileUseCase(
                                instance<ImageRepository>())
                            .call(image!, imagePicked!.name, "adImages");
                        isLoaded.fold((failure) {
                          showCustomDialog(context,
                              message: failure.message.tr(context));
                        },(r) {
                          showCustomDialog(context,
                              message: AppStrings.imageAddedSuccessfully
                                  .tr(context));
                        });
                      }
                    : () {
                        showCustomDialog(context,
                            message:
                                AppStrings.pleaseSelectImage.tr(context));
                      }),
              ),
              ControlPanelButton(
                  buttonTitle: "عرض الصور",
                  onTap: () {
                    BlocProvider.of<GalleryBloc>(context).add(GetImageGallery());
                    Navigator.pushNamed(context, Routes.photoGalleryRoute);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
