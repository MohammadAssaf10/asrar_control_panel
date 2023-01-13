import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:asrar_control_panel/features/home/domain/repositories/file_repository.dart';
import 'package:asrar_control_panel/features/home/domain/use_cases/delete_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/di.dart';
import '../../../../core/app/functions.dart';
import '../manager/photo_gallery_bloc/gallery_bloc.dart';

class PhotoGalleryScreen extends StatelessWidget {
  const PhotoGalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DeleteFileUseCase deleteFileUseCase =
        DeleteFileUseCase(fileRepository: instance<FileRepository>());
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.photoGallery.tr(context)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                // horizontal: AppSize.s10.w,
                vertical: AppSize.s10.h,
              ),
              child: Text(
                AppStrings.longPressOnTheImageToDelete.tr(context),
                style: getAlmaraiBoldStyle(
                  fontSize: AppSize.s20.sp,
                  color: ColorManager.primary,
                ),
              ),
            ),
            BlocBuilder<GalleryBloc, GalleryState>(
              builder: (context, state) {
                if (state is GalleryLoadingState) {
                  return const Center(
                    child:
                        CircularProgressIndicator(color: ColorManager.primary),
                  );
                } else if (state is GalleryErrorState) {
                  return Text(
                    state.errorMessage,
                    style: getAlmaraiRegularStyle(
                        fontSize: AppSize.s20.sp, color: ColorManager.error),
                  );
                } else if (state is GalleryLoadedState) {
                  if (state.list.isNotEmpty) {
                    return Center(
                      child: SizedBox(
                        width: AppSize.s200.w,
                        child: ListView.builder(
                          itemCount: state.list.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onLongPress: () {
                                showCustomDialog(context);
                                deleteFileUseCase(
                                        "adImages", state.list[index].name)
                                    .whenComplete(
                                  () {
                                    dismissDialog(context);
                                    showCustomDialog(context,
                                      message: "تم الحذف");}
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: AppSize.s12.h,
                                ),
                                height: AppSize.s250.h,
                                decoration: BoxDecoration(
                                  color: ColorManager.grey,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      state.list[index].url,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        AppStrings.noPictures.tr(context),
                        style: getAlmaraiRegularStyle(
                          fontSize: AppSize.s25.sp,
                          color: ColorManager.primary,
                        ),
                      ),
                    );
                  }
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
