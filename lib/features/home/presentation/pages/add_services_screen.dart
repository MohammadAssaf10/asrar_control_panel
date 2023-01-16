import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../../domain/entities/service_entities.dart';
import '../blocs/company/company_bloc.dart';
import '../blocs/services_bloc/services_bloc.dart';
import '../widgets/control_panel_button.dart';
import '../widgets/input_field.dart';
import '../../../../core/app/extensions.dart';

class AddServicesScreen extends StatefulWidget {
  const AddServicesScreen({Key? key}) : super(key: key);

  @override
  State<AddServicesScreen> createState() => _AddServicesScreenState();
}

class _AddServicesScreenState extends State<AddServicesScreen> {
  String? dropdownValue;
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _servicesNameController = TextEditingController();
  final TextEditingController _requiredDocumentsController =
      TextEditingController();
  List<String> list = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServicesBloc, ServicesState>(
      listener: (context, state) {
        if (state is AddedServiceLoadingState) {
          showCustomDialog(context);
        } else if (state is AddedServiceErrorState) {
          print("Error------->${state.errorMessage}");
          dismissDialog(context);
          showCustomDialog(context, message: state.errorMessage.tr(context));
        } else if (state is AddedServiceSuccessfullyState) {
          dismissDialog(context);
          showCustomDialog(context,
              message: AppStrings.addedSuccessfully.tr(context));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.addServices.tr(context),
          ),
        ),
        body: Center(
          child: Container(
            width: AppSize.s180.w,
            height: AppSize.s500.h,
            color: ColorManager.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: AppSize.s80.h),
                  BlocBuilder<CompanyBloc, CompanyState>(
                    builder: (context, state) {
                      if (state is CompanyLoadingState) {
                        return Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: AppSize.s15.h),
                          child: Text(AppStrings.loading.tr(context)),
                        );
                      } else if (state is CompanyErrorState) {
                        return Center(
                          child: Text(state.errorMessage.tr(context)),
                        );
                      } else if (state is CompanyLoadedState) {
                        if (state.company.isNotEmpty) {
                          return Container(
                            margin:
                                EdgeInsets.symmetric(vertical: AppSize.s10.h),
                            height: AppSize.s50.h,
                            child: DropdownButton<String>(
                              hint: Text(dropdownValue ??
                                  AppStrings.makeASelection.tr(context)),
                              items: state.company
                                  .map<DropdownMenuItem<String>>((company) {
                                return DropdownMenuItem<String>(
                                    value: company.name,
                                    child: Text(company.name));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dropdownValue = value;
                                });
                              },
                            ),
                          );
                        } else {
                          return Container(
                            alignment: Alignment.center,
                            margin:
                                EdgeInsets.symmetric(vertical: AppSize.s15.h),
                            child: Text(AppStrings.noCompanies.tr(context)),
                          );
                        }
                      }
                      return const SizedBox();
                    },
                  ),
                  InputField(
                    widget: Text(
                      AppStrings.servicesName.tr(context),
                      style: getAlmaraiRegularStyle(
                        fontSize: AppSize.s16.sp,
                        color: ColorManager.primary,
                      ),
                    ),
                    controller: _servicesNameController,
                    hintTitle: AppStrings.servicesName.tr(context),
                    keyboardType: TextInputType.name,
                    regExp: RegExp('[" "a-zأ-يA-Zا-ي]'),
                  ),
                  InputField(
                    widget: Text(
                      AppStrings.servicesPrice.tr(context),
                      style: getAlmaraiRegularStyle(
                        fontSize: AppSize.s16.sp,
                        color: ColorManager.primary,
                      ),
                    ),
                    controller: _priceController,
                    hintTitle: AppStrings.servicesPrice.tr(context),
                    keyboardType: TextInputType.number,
                    regExp: RegExp('[0-9]'),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Text(
                            "- ${list[index]}",
                            style: getAlmaraiRegularStyle(
                              fontSize: AppSize.s16.sp,
                              color: ColorManager.primary,
                            ),
                          ),
                        );
                      }),
                  InputField(
                    widget: MaterialButton(
                      height: double.infinity,
                      color: ColorManager.primary,
                      onPressed: () {
                        if (_requiredDocumentsController.text.isNotEmpty) {
                          setState(() {
                            list.add(_requiredDocumentsController.text);
                            _requiredDocumentsController.clear();
                          });
                        }
                      },
                      child: Text(
                        AppStrings.add.tr(context),
                        style: getAlmaraiRegularStyle(
                          fontSize: AppSize.s16.sp,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                    controller: _requiredDocumentsController,
                    hintTitle: AppStrings.requiredDocuments.tr(context),
                    keyboardType: TextInputType.text,
                    regExp: RegExp('[" "a-zأ-يA-Zا-ي]'),
                  ),
                  ControlPanelButton(
                    buttonTitle: AppStrings.add.tr(context),
                    onTap: () {
                      if (list.isNotEmpty &&
                          _priceController.text.isNotEmpty &&
                          _servicesNameController.text.isNotEmpty &&
                          !dropdownValue.nullOrEmpty()) {
                        final ServiceEntities serviceEntities = ServiceEntities(
                          companyName: dropdownValue!,
                          serviceName: _servicesNameController.text,
                          servicePrice: double.parse(_priceController.text),
                          requiredDocuments: list,
                        );
                        BlocProvider.of<ServicesBloc>(context).add(
                            AddServicesEvent(serviceEntities: serviceEntities));
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
