import 'dart:io';

import 'package:asrar_control_panel/config/app_localizations.dart';
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
import '../../../domain/entities/course_entities.dart';
import '../../../domain/entities/xfile_entities.dart';
import '../../../domain/use_cases/select_image_for_web.dart';
import '../../blocs/course_bloc/course_bloc.dart';
import '../../widgets/control_panel_button.dart';
import '../../widgets/input_field.dart';

class AddCoursesScreen extends StatefulWidget {
  const AddCoursesScreen({super.key});

  @override
  State<AddCoursesScreen> createState() => _AddCoursesScreenState();
}

class _AddCoursesScreenState extends State<AddCoursesScreen> {
  File? image;
  final SelectImageForWebUseCase selectImageForWebUseCase =
      SelectImageForWebUseCase();

  Uint8List webImage = Uint8List(8);
  late XFileEntities xFileEntities;

  final TextEditingController _coursesTitileController =
      TextEditingController();
  final TextEditingController _coursesContentController =
      TextEditingController();
  final TextEditingController _coursesPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseBloc, CourseState>(
      listener: (context, state) {
        if (state is CourseLoadingState) {
          showCustomDialog(context);
        } else if (state is CourseErrorState) {
          showCustomDialog(context, message: state.errorMessage.tr(context));
        } else if (state is CourseAddedSuccessfullyState) {
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
            alignment: Alignment.center,
            child: ListView(
              children: [
                image == null
                    ? Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSize.s20.h),
                          child: Text(
                            AppStrings.pleaseSelectImage.tr(context),
                            textAlign: TextAlign.center,
                            style: getAlmaraiRegularStyle(
                                fontSize: AppSize.s20.sp,
                                color: ColorManager.primary),
                          ),
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
                  controller: _coursesTitileController,
                  labelText: AppStrings.newsTitile.tr(context),
                  regExp: getAllKeyboradInputFormat(),
                  height: AppSize.s80.h,
                ),
                InputField(
                  controller: _coursesPriceController,
                  labelText: AppStrings.newsContent.tr(context),
                  regExp: getDoubleInputFormat(),
                  height: AppSize.s50.h,
                ),
                InputField(
                  controller: _coursesContentController,
                  labelText: AppStrings.courseContent.tr(context),
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
                        _coursesContentController.text.isNotEmpty &&
                        _coursesTitileController.text.isNotEmpty &&
                        _coursesPriceController.text.isNotEmpty) {
                      final CourseEntities course = CourseEntities(
                        courseTitile: _coursesTitileController.text,
                        courseContent: _coursesContentController.text,
                        coursePrice: _coursesPriceController.text,
                        courseImageName: image!.path,
                        courseImageUrl: "",
                        timestamp: Timestamp.now(),
                      );
                      BlocProvider.of<CourseBloc>(context).add(
                        AddCourseEvent(
                          course: course,
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
    );
  }
}
