import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../domain/entities/service_order.dart';

class ServiceOrderView extends StatelessWidget {
  const ServiceOrderView({Key? key, required this.serviceOrder})
      : super(key: key);
  final ServiceOrder serviceOrder;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: AppSize.s95.h,
        width: AppSize.s130.w,
        margin: EdgeInsets.symmetric(vertical: AppSize.s10.h),
        padding: EdgeInsets.symmetric(
          vertical: AppSize.s5.h,
          horizontal: AppSize.s5.w,
        ),
        color: ColorManager.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppStrings.orderNumber.tr(context)}: ${serviceOrder.id.toString()}',
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.primary,
              ),
            ),
            Text(
              '${AppStrings.servicesName.tr(context)}: ${serviceOrder.service.serviceName}',
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.primary,
              ),
            ),
            Text(
              '${AppStrings.customer.tr(context)}: ${serviceOrder.user.name}',
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.primary,
              ),
            ),
            Visibility(
              visible: serviceOrder.employee.name.isNotEmpty,
              child: Text(
                '${AppStrings.employee.tr(context)}: ${serviceOrder.employee.name}',
                style: getAlmaraiRegularStyle(
                  fontSize: AppSize.s18.sp,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
