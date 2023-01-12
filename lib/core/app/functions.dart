import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../config/color_manager.dart';
import '../../config/strings_manager.dart';
import '../../config/styles_manager.dart';
import '../../config/values_manager.dart';

bool isEmailFormatCorrect(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isMobileNumberCorrect(String mobileNumber) {
  return RegExp(r"^[+]*[0-9]+").hasMatch(mobileNumber);
}

_isCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

dismissDialog(BuildContext context) {
  if (_isCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

void showCustomDialog(BuildContext context,
    {String? message, String? jsonPath}) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    dismissDialog(context);
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Padding(
          padding: EdgeInsets.all(AppSize.s8.h),
          child: Container(
            width: AppSize.s200.w,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(AppSize.s10.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (jsonPath != null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSize.s10.h,
                      horizontal: AppSize.s10.w,
                    ),
                    child: Lottie.asset(jsonPath),
                  ),
                if (message != null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSize.s10.h,
                      horizontal: AppSize.s10.w,
                    ),
                    child: Center(
                      child: Text(
                        message,
                        style: getAlmaraiRegularStyle(
                          fontSize: AppSize.s20.sp,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
                if (jsonPath != null || message != null)
                  Container(
                    margin: EdgeInsets.only(bottom: AppSize.s5.h),
                    width: AppSize.s120.w,
                    height: AppSize.s30.h,
                    child: ElevatedButton(
                      onPressed: () => dismissDialog(context),
                      child: Text(
                        AppStrings.ok.tr(context),
                        style: getAlmaraiRegularStyle(
                          fontSize: AppSize.s18.sp,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                if (jsonPath == null && message == null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSize.s8.h,
                      horizontal: AppSize.s8.w,
                    ),
                    child: const CircularProgressIndicator(
                      color: ColorManager.primary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  });
}
