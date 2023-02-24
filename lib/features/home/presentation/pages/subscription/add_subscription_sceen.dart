import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:asrar_control_panel/config/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../domain/entities/subscription_entities.dart';
import '../../blocs/subscription_bloc/subscription_bloc.dart';
import '../../blocs/subscription_bloc/subscription_state.dart';
import '../../widgets/control_panel_button.dart';
import '../../widgets/input_field.dart';

class AddSubscriptionScreen extends StatefulWidget {
  const AddSubscriptionScreen({super.key});

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool havePrice = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        if (state.subscriptionStatus ==
            SubscriptionStatus.subscriptionLoading) {
          showCustomDialog(context);
        }
        if (state.subscriptionStatus == SubscriptionStatus.subscriptionError) {
          showCustomDialog(context, message: state.errorMessage);
        } else if (state.subscriptionStatus ==
            SubscriptionStatus.subscriptionAdded) {
          showCustomDialog(context,
              message: AppStrings.addedSuccessfully.tr(context));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.addServicesCompany.tr(context)),
        ),
        body: Center(
          child: Container(
            width: AppSize.s200.w,
            height: AppSize.s550.h,
            color: ColorManager.white,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  InputField(
                    controller: titleController,
                    labelText: AppStrings.subscriptionName.tr(context),
                    regExp: getTextWithNumberInputFormat(),
                    height: AppSize.s50.h,
                  ),
                  Visibility(
                    visible: havePrice,
                    child: InputField(
                      controller: priceController,
                      labelText:
                          AppStrings.subscriptionPrice.tr(context),
                      regExp: getDoubleInputFormat(),
                      height: AppSize.s50.h,
                    ),
                  ),
                  CheckboxListTile(
                    value: havePrice,
                    contentPadding: EdgeInsets.symmetric(horizontal: AppSize.s35.w),
                    title: Text(
                      AppStrings.subscriptionPrice.tr(context),
                      style: getAlmaraiBoldStyle(
                        fontSize: AppSize.s15.sp,
                        color: ColorManager.primary,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: ColorManager.primary,
                    onChanged: (v) {
                      priceController.clear();
                      setState(() {
                        havePrice = !havePrice;
                      });
                    },
                  ),
                  ControlPanelButton(
                    buttonTitle: AppStrings.add.tr(context),
                    onTap: () {
                      if (havePrice) {
                        if (titleController.text.isNotEmpty &&
                            priceController.text.isNotEmpty) {
                          final SubscriptionEntities subscription =
                              SubscriptionEntities(
                            subscriptionName: titleController.text,
                            subscriptionPrice: priceController.text,
                          );
                          BlocProvider.of<SubscriptionBloc>(context).add(
                              AddSubscriptionEvent(subscription: subscription));
                        } else {
                          showCustomDialog(context,
                              message: AppStrings.pleaseEnterAllRequiredData
                                  .tr(context));
                        }
                      } else {
                        if (titleController.text.isNotEmpty) {
                          final SubscriptionEntities subscription =
                              SubscriptionEntities(
                            subscriptionName: titleController.text,
                            subscriptionPrice: "",
                          );
                          BlocProvider.of<SubscriptionBloc>(context).add(
                              AddSubscriptionEvent(subscription: subscription));
                        } else {
                          showCustomDialog(context,
                              message: AppStrings.pleaseEnterAllRequiredData
                                  .tr(context));
                        }
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
