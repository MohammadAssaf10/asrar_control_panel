import 'package:flutter/foundation.dart';
import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import '../../../../config/color_manager.dart';
import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/di.dart';
import '../../../../core/app/functions.dart';
import '../../domain/entities/xfile_entities.dart';
import '../../domain/repositories/storage_file_repository.dart';
import '../../domain/use_cases/select_image_for_web.dart';
import '../blocs/photo_gallery_bloc/gallery_bloc.dart';
import '../widgets/control_panel_button.dart';

class AddAdImageScreen extends StatefulWidget {
  const AddAdImageScreen({Key? key}) : super(key: key);

  @override
  State<AddAdImageScreen> createState() => _AddAdImageScreenState();
}

class _AddAdImageScreenState extends State<AddAdImageScreen> {
  final StorageFileRepository storageFileRepository =
      instance<StorageFileRepository>();
  final SelectImageForWebUseCase selectImageForWebUseCase =
      SelectImageForWebUseCase();
  Uint8List webImage = Uint8List(8);
  File? image;

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
                      child: Image.memory(
                        webImage,
                        width: double.infinity,
                      ),
                    ),
              ControlPanelButton(
                buttonTitle: AppStrings.selectImage.tr(context),
                onTap: () async {
                  final XFileEntities? xFileEntities =
                      await selectImageForWebUseCase();
                  setState(() {
                    webImage = xFileEntities!.xFileAsBytes;
                    image = File(xFileEntities.name);
                  });
                },
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.uploadImage.tr(context),
                onTap: (image != null
                    ? () async {
                        showCustomDialog(context);
                        final XFileEntities xFileEntities = XFileEntities(
                            name: image!.path, xFileAsBytes: webImage);
                        final isUploaded = await storageFileRepository
                            .uploadFile(xFileEntities, "adImages");
                        isUploaded.fold((failure) {
                          dismissDialog(context);
                          showCustomDialog(context,
                              message: failure.message.tr(context));
                        }, (r) {
                          r.whenComplete(() {
                            dismissDialog(context);
                            showCustomDialog(context,
                                message:
                                    AppStrings.addedSuccessfully.tr(context));
                          });
                        });
                      }
                    : () {
                        showCustomDialog(context,
                            message: AppStrings.pleaseSelectImage.tr(context));
                      }),
              ),
              ControlPanelButton(
                  buttonTitle: AppStrings.deleteImage.tr(context),
                  onTap: () {
                    BlocProvider.of<GalleryBloc>(context)
                        .add(GetImageGallery());
                    Navigator.pushNamed(context, Routes.photoGalleryRoute);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
