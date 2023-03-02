import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:asrar_control_panel/core/app/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../blocs/photo_gallery_bloc/ad_image_bloc.dart';
import '../../widgets/empty_list_view.dart';
import '../../widgets/error_view.dart';
import '../../widgets/image_network.dart';
import '../../widgets/loading_view.dart';

class PhotoGalleryScreen extends StatelessWidget {
  const PhotoGalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.photoGallery.tr(context)),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
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
          ),
          BlocConsumer<AdImageBloc, AdImageState>(
            listener: (context, state) {
              if (state is ImageDeletedSuccessfullyState) {
                showCustomDialog(
                  context,
                  message: AppStrings.deletedSuccessfully.tr(context),
                );
                BlocProvider.of<AdImageBloc>(context).add(GetAdImagesEvent());
              } else if (state is DeleteAdImageErrorState) {
                showCustomDialog(
                  context,
                  message: state.errorMessage.tr(context),
                );
                BlocProvider.of<AdImageBloc>(context).add(GetAdImagesEvent());
              } else if (state is DeleteAdImageLoadingState) {
                showCustomDialog(context);
              }
            },
            builder: (context, state) {
              return BlocBuilder<AdImageBloc, AdImageState>(
                builder: (context, state) {
                  if (state is AdImageLoadingState) {
                    return LoadingView(
                      height: AppSize.s550.h,
                      width: double.infinity,
                    );
                  } else if (state is AdImageErrorState) {
                    return ErrorView(
                      errorMessage: state.errorMessage.tr(context),
                      height: AppSize.s550.h,
                      width: double.infinity,
                    );
                  } else if (state is AdImagesLoadedState) {
                    if (state.adImagesList.isNotEmpty) {
                      return ListView.builder(
                        physics: const ScrollPhysics(),
                        itemCount: state.adImagesList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: InkWell(
                              onLongPress: () {
                                BlocProvider.of<AdImageBloc>(context)
                                    .add(DeleteAdImageEvent(
                                  adImage: state.adImagesList[index],
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: AppSize.s12.h,
                                ),
                                width: AppSize.s200.w,
                                height: AppSize.s250.h,
                                decoration: const BoxDecoration(
                                  color: ColorManager.grey,
                                ),
                                child: ImageNetwork(
                                  image: state.adImagesList[index].adImageUrl,
                                  boxFit: BoxFit.fill,
                                  loadingHeight: AppSize.s250.h,
                                  loadingWidth: AppSize.s200.w,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return EmptyListView(
                        emptyListMessage: AppStrings.noPictures.tr(context),
                        height: AppSize.s550.h,
                        width: double.infinity,
                      );
                    }
                  } else {
                    return const SizedBox();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
