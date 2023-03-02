import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';

class SubTitleTable extends StatelessWidget {
  const SubTitleTable({Key? key, required this.subTitle}) : super(key: key);
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      textAlign: TextAlign.center,
      style: getAlmaraiRegularStyle(
        fontSize: AppSize.s18.sp,
        color: ColorManager.primary,
      ),
    );
  }
}
