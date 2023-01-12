import 'package:flutter/foundation.dart';
import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../config/color_manager.dart';
import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/di.dart';
import '../../../../core/app/functions.dart';
import '../../domain/repositories/file_repository.dart';
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
  final UploadFileUseCase uploadFileUseCase =
      UploadFileUseCase(instance<FileRepository>());
  File? image;
  Uint8List webImage = Uint8List(8);

  void selectImage() async {
    // Pick an image
    if (!kIsWeb) {
      XFile? imagePicked = await _picker.pickImage(source: ImageSource.gallery);
      if (imagePicked != null) {
        File selected = File(imagePicked.path);
        setState(() {
          image = selected;
        });
      }
    } else if (kIsWeb) {
      XFile? imagePicked = await _picker.pickImage(source: ImageSource.gallery);
      if (imagePicked != null) {
        Uint8List selected = await imagePicked.readAsBytes();
        String selectName = imagePicked.name;
        setState(() {
          webImage = selected;
          image = File(selectName);
        });
      }
    } else {
      print("\\\\\\\\ Something wrong \\\\\\\\");
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
                      child: Image.memory(
                        webImage,
                        width: double.infinity,
                      ),
                    ),
              ControlPanelButton(
                buttonTitle: AppStrings.selectImage.tr(context),
                onTap: () => selectImage(),
              ),
              ControlPanelButton(
                buttonTitle: AppStrings.uploadImage.tr(context),
                onTap: (image != null
                    ? () async {
                        final isLoaded = await uploadFileUseCase(
                            webImage, image!.path, "adImages");
                        isLoaded.fold((failure) {
                          showCustomDialog(context,
                              message: failure.message.tr(context));
                        }, (r) {
                          r.whenComplete(() {
                            showCustomDialog(context,
                                message: AppStrings.imageAddedSuccessfully
                                    .tr(context));
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
