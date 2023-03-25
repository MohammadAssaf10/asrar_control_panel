import 'dart:io';

import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:asrar_control_panel/features/home/domain/entities/news_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../domain/entities/xfile_entities.dart';
import '../../../domain/use_cases/select_image_for_web.dart';
import '../../blocs/news_bloc/news_bloc.dart';
import '../../widgets/control_panel_button.dart';
import '../../widgets/input_field.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({super.key});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  File? image;
  final SelectImageForWebUseCase selectImageForWebUseCase =
      SelectImageForWebUseCase();

  Uint8List webImage = Uint8List(8);
  late XFileEntities xFileEntities;

  final TextEditingController _newsTitileController = TextEditingController();
  final TextEditingController _newsContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewsBloc, NewsState>(
      listener: (context, state) {
        if (state is NewsLoadingState) {
          showCustomDialog(context);
        } else if (state is NewsErrorState) {
          showCustomDialog(context, message: state.errorMessage.tr(context));
        } else if (state is NewsAddedSuccessfullyState) {
          showCustomDialog(context,
              message: AppStrings.addedSuccessfully.tr(context));
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
            width: AppSize.s200.w,
            height: AppSize.s550.h,
            color: ColorManager.white,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  image == null
                      ? Padding(
                          padding: EdgeInsets.only(bottom: AppSize.s20.h),
                          child: Text(
                            AppStrings.pleaseSelectImage.tr(context),
                            textAlign: TextAlign.center,
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
                    controller: _newsTitileController,
                    labelText: AppStrings.newsTitile.tr(context),
                    regExp: getAllKeyboradInputFormat(),
                    height: AppSize.s80.h,
                  ),
                  InputField(
                    controller: _newsContentController,
                    labelText: AppStrings.newsContent.tr(context),
                    regExp: getAllKeyboradInputFormat(),
                    height: AppSize.s120.h,
                  ),
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
                          _newsContentController.text.isNotEmpty &&
                          _newsTitileController.text.isNotEmpty) {
                        final NewsEntities news = NewsEntities(
                          newsId: 0,
                          timestamp: Timestamp.now(),
                          newsTitle: _newsTitileController.text,
                          newsContent: _newsContentController.text,
                          newsImageName: image!.path,
                          newsImageUrl: "",
                        );
                        BlocProvider.of<NewsBloc>(context).add(
                          AddNewsEvent(
                            news: news,
                            xFileEntities: xFileEntities,
                          ),
                        );
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
    );
  }
}
