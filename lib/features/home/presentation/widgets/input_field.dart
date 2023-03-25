import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/values_manager.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.labelText,
    required this.regExp,
    required this.controller,
    required this.height,
    this.width,
  }) : super(key: key);
  final String labelText;
  final RegExp regExp;
  final TextEditingController controller;
  final double height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width??AppSize.s130.w,
        margin: EdgeInsets.symmetric(vertical: AppSize.s10.h),
        child: TextFormField(
          controller: controller,
          maxLines: null,
          textAlign: TextAlign.center,
          inputFormatters: [
            FilteringTextInputFormatter.allow(regExp),
          ],
          expands: true,
          decoration: InputDecoration(
            labelText: labelText,
          ),
        ),
      ),
    );
  }
}
