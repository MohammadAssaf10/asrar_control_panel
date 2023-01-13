import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';

class ControlPanelButton extends StatelessWidget {
  const ControlPanelButton({
    Key? key,
    required this.buttonTitle,
    required this.onTap,
  }) : super(key: key);
  final String buttonTitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppSize.s140.w,
        height: AppSize.s60.h,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.s10.w,
            vertical: AppSize.s10.h,
          ),
          child: ElevatedButton(
            onPressed: () => onTap(),
            child: Text(
              buttonTitle,
              textAlign: TextAlign.center,
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s20.sp,
                color: ColorManager.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
