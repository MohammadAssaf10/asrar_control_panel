import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';

class TitleTable extends StatelessWidget {
  const TitleTable({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: getAlmaraiBoldStyle(
          fontSize: AppSize.s17.sp,
          color: ColorManager.primary,
        ),
      ),
    );
  }
}
