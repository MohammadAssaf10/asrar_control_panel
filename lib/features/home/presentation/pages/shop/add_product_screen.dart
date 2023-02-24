import 'dart:io';

import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../domain/entities/product_entities.dart';
import '../../../domain/entities/xfile_entities.dart';
import '../../blocs/product/product_bloc.dart';
import '../../widgets/control_panel_button.dart';
import '../../../domain/use_cases/select_image_for_web.dart';
import '../../widgets/input_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  File? image;
  final SelectImageForWebUseCase selectImageForWebUseCase =
      SelectImageForWebUseCase();

  Uint8List webImage = Uint8List(8);
  late XFileEntities xFileEntities;

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductLoadingState) {
          showCustomDialog(context);
        } else if (state is ProductErrorState) {
          showCustomDialog(context, message: state.errorMessage.tr(context));
        } else if (state is ProductAddedSuccessfullyState) {
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
                    controller: _productNameController,
                    labelText: AppStrings.productName.tr(context),
                    regExp: getTextWithNumberInputFormat(),
                    height: AppSize.s50.h,
                  ),
                  InputField(
                    controller: _priceController,
                    labelText: AppStrings.productPrice.tr(context),
                    regExp: getDoubleInputFormat(),
                    height: AppSize.s50.h,
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
                          _priceController.text.isNotEmpty &&
                          _productNameController.text.isNotEmpty) {
                        final ProductEntities productEntities =
                            ProductEntities(
                          productName: _productNameController.text,
                          productPrice: _priceController.text,
                          productImageUrl: "",
                          productImageName: image!.path,
                          productCount: 1
                        );
                        BlocProvider.of<ProductBloc>(context)
                            .add(AddProductEvent(
                          productEntities: productEntities,
                          xFileEntities: xFileEntities,
                        ));
                      }
                      showCustomDialog(context,
                          message: AppStrings.pleaseEnterAllRequiredData
                              .tr(context));
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
