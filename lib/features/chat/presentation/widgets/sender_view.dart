import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../domain/entities/message.dart';

class SenderView extends StatelessWidget {
  const SenderView({Key? key, required this.sender}) : super(key: key);
  final Sender sender;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: AppSize.s70.h,
        width: AppSize.s130.w,
        margin: EdgeInsets.symmetric(vertical: AppSize.s10.h),
        padding: EdgeInsets.symmetric(
          vertical: AppSize.s5.h,
          horizontal: AppSize.s5.w,
        ),
        color: ColorManager.white,
        child: Text(
          '${AppStrings.customer.tr(context)}: ${sender.name}',
          textAlign: TextAlign.center,
          style: getAlmaraiRegularStyle(
            fontSize: AppSize.s18.sp,
            color: ColorManager.primary,
          ),
        ),
      ),
    );
  }
}
