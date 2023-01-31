import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/values_manager.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.hintTitle,
    required this.keyboardType,
    required this.regExp,
    required this.controller,
  }) : super(key: key);
  final String hintTitle;
  final TextInputType keyboardType;
  final RegExp regExp;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppSize.s10.h),
      width: AppSize.s120.w,
      height: AppSize.s40.h,
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: keyboardType,
        inputFormatters: [
          FilteringTextInputFormatter.allow(regExp),
        ],
        decoration: InputDecoration(
          hintText: hintTitle,
        ),
      ),
    );
  }
}
