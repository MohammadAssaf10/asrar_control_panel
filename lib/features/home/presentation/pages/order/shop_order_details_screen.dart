import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:asrar_control_panel/core/app/constants.dart';
import 'package:asrar_control_panel/core/app/functions.dart';
import 'package:asrar_control_panel/features/home/presentation/widgets/control_panel_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../domain/entities/shop_order_entities.dart';
import '../../blocs/shop_order_bloc/shop_order_bloc.dart';

class ShopOrderDetailsScreen extends StatelessWidget {
  const ShopOrderDetailsScreen(this.shopOrder, {super.key});
  final ShopOrderEntities shopOrder;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${AppStrings.orderNumber.tr(context)}: ${shopOrder.shopOrderId.toString()}",
        ),
      ),
      body: BlocListener<ShopOrderBloc, ShopOrderState>(
        listener: (BuildContext context, ShopOrderState state) {
          if (state is UpdateShopOrderStatusLoadingState) {
            showCustomDialog(context);
          } else if (state is UpdateShopOrderStatusErrorState) {
            showCustomDialog(context, message: state.errorMessage.tr(context));
            BlocProvider.of<ShopOrderBloc>(context).add(GetShopOrderEvent());
          } else if (state is UpdateShopOrderStatusSuccessfullyState) {
            showCustomDialog(context,
                message: shopOrder.orderStatus == OrderStatus.pending.name
                    ? AppStrings.orderAccepted.tr(context)
                    : AppStrings.orderFinished.tr(context), onTap: () {
              Navigator.pop(context);
            });
            BlocProvider.of<ShopOrderBloc>(context).add(GetShopOrderEvent());
          }
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: shopOrder.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Container(
                      height: AppSize.s100.h,
                      width: AppSize.s120.w,
                      margin: EdgeInsets.symmetric(
                        vertical: AppSize.s8.h,
                      ),
                      decoration: ShapeDecoration(
                        color: ColorManager.white,
                        shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            AppSize.s18.r,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s10.r),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    shopOrder.products[index].productImageUrl,
                                  ),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: ColorManager.grey,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: AppSize.s5.w,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${AppStrings.productName.tr(context)}: ${shopOrder.products[index].productName}",
                                    style: getAlmaraiBoldStyle(
                                      fontSize: AppSize.s17.sp,
                                      color: ColorManager.primary,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: AppSize.s4.h),
                                  Text(
                                    "${AppStrings.productPrice.tr(context)}: ${shopOrder.products[index].productPrice} ر.س",
                                    style: getAlmaraiBoldStyle(
                                      fontSize: AppSize.s17.sp,
                                      color: ColorManager.primary,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(height: AppSize.s4.h),
                                  Text(
                                    "${AppStrings.number.tr(context)}: ${shopOrder.products[index].productCount}",
                                    style: getAlmaraiBoldStyle(
                                      fontSize: AppSize.s17.sp,
                                      color: ColorManager.primary,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: (shopOrder.orderStatus == OrderStatus.canceled.name ||
                      shopOrder.orderStatus == OrderStatus.finished.name)
                  ? false
                  : true,
              child: ControlPanelButton(
                onTap: () {
                  if (shopOrder.orderStatus == OrderStatus.inProgress.name) {
                    BlocProvider.of<ShopOrderBloc>(context).add(
                      UpdateShopOrderStatusEvent(
                          shopOrder: shopOrder,
                          newStatus: OrderStatus.finished),
                    );
                  } else if (shopOrder.orderStatus ==
                      OrderStatus.pending.name) {
                    BlocProvider.of<ShopOrderBloc>(context).add(
                      UpdateShopOrderStatusEvent(
                          shopOrder: shopOrder,
                          newStatus: OrderStatus.inProgress),
                    );
                  }
                },
                buttonTitle: shopOrder.orderStatus == OrderStatus.pending.name
                    ? AppStrings.acceptOrder.tr(context)
                    : AppStrings.finishOrder.tr(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
