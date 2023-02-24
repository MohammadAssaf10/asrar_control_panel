import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:asrar_control_panel/config/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../blocs/shop_order_bloc/shop_order_bloc.dart';
import '../../widgets/empty_list_view.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_view.dart';

class ShopOrderScreen extends StatelessWidget {
  const ShopOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.shopOrder.tr(context),
          ),
        ),
        body: BlocBuilder<ShopOrderBloc, ShopOrderState>(
          builder: (context, state) {
            if (state is ShopOrderLoadingState) {
              return LoadingView(
                height: AppSize.s550.h,
                width: double.infinity,
              );
            } else if (state is ShopOrderErrorState) {
              return ErrorView(
                errorMessage: state.errorMessage.tr(context),
                height: AppSize.s550.h,
                width: double.infinity,
              );
            } else if (state is ShopOrderLoadedState) {
              if (state.shopOrderList.isNotEmpty) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppStrings.orderNumber.tr(context),
                            textAlign: TextAlign.center,
                            style: getAlmaraiBoldStyle(
                              fontSize: AppSize.s18.sp,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            AppStrings.mobileNumber.tr(context),
                            textAlign: TextAlign.center,
                            style: getAlmaraiBoldStyle(
                              fontSize: AppSize.s18.sp,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            AppStrings.userName.tr(context),
                            textAlign: TextAlign.center,
                            style: getAlmaraiBoldStyle(
                              fontSize: AppSize.s18.sp,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            AppStrings.orderPrice.tr(context),
                            textAlign: TextAlign.center,
                            style: getAlmaraiBoldStyle(
                              fontSize: AppSize.s18.sp,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            AppStrings.status.tr(context),
                            textAlign: TextAlign.center,
                            style: getAlmaraiBoldStyle(
                              fontSize: AppSize.s18.sp,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s10.h),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.shopOrderList.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: ColorManager.grey,
                            thickness: AppSize.s2.h,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.shopOrderDetailsRoute,
                                arguments: state.shopOrderList[index],
                              );
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    state.shopOrderList[index].shopOrderId
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: getAlmaraiRegularStyle(
                                      fontSize: AppSize.s18.sp,
                                      color: ColorManager.primary,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    state.shopOrderList[index].phoneNumber,
                                    textAlign: TextAlign.center,
                                    style: getAlmaraiRegularStyle(
                                      fontSize: AppSize.s18.sp,
                                      color: ColorManager.primary,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    state.shopOrderList[index].user.name,
                                    textAlign: TextAlign.center,
                                    style: getAlmaraiRegularStyle(
                                      fontSize: AppSize.s18.sp,
                                      color: ColorManager.primary,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${state.shopOrderList[index].totalPrice} ر.س",
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                    style: getAlmaraiRegularStyle(
                                      fontSize: AppSize.s18.sp,
                                      color: ColorManager.primary,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    state.shopOrderList[index].orderStatus
                                        .tr(context),
                                    textAlign: TextAlign.center,
                                    style: getAlmaraiRegularStyle(
                                      fontSize: AppSize.s18.sp,
                                      color: ColorManager.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return EmptyListView(
                  emptyListMessage: "",
                  height: AppSize.s550.h,
                  width: double.infinity,
                );
              }
            }
            return const SizedBox();
          },
        ));
  }
}
