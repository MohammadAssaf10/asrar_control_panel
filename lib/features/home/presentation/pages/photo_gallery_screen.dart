import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../manager/photo_gallery_bloc/gallery_bloc.dart';

class PhotoGalleryScreen extends StatelessWidget {
  const PhotoGalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("معرض الصور"),
      ),
      body: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          if (state is GalleryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          } else if (state is GalleryErrorState) {
            return Text(
              state.errorMessage,
              style: getAlmaraiRegularStyle(
                  fontSize: AppSize.s20.sp, color: ColorManager.error),
            );
          } else if (state is GalleryLoadedState) {
            if (state.list.isNotEmpty) {
              return SizedBox(
                height: double.infinity,
                child: ListView.builder(
                  itemCount: state.list.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: AppSize.s12.h,
                      ),
                      height: AppSize.s200.h,
                      width: AppSize.s200.w,
                      decoration: BoxDecoration(
                        color: ColorManager.grey,
                        image: DecorationImage(
                          image: NetworkImage(
                            state.list[index].url,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Text(
                  "لا يوجد صور",
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
    );
  }
}
