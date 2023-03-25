import 'package:asrar_control_panel/config/app_localizations.dart';
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
import '../../widgets/table_subtitle.dart';
import '../../widgets/table_title.dart';

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
                        TitleTable(title: AppStrings.orderNumber.tr(context)),
                        TitleTable(title: AppStrings.mobileNumber.tr(context)),
                        TitleTable(title: AppStrings.userName.tr(context)),
                        TitleTable(title: AppStrings.orderPrice.tr(context)),
                        TitleTable(title: AppStrings.status.tr(context)),
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
                                  child: SubTitleTable(
                                    subTitle: state
                                        .shopOrderList[index].shopOrderId
                                        .toString(),
                                  ),
                                ),
                                Expanded(
                                  child: SubTitleTable(
                                    subTitle:
                                        state.shopOrderList[index].phoneNumber,
                                  ),
                                ),
                                Expanded(
                                  child: SubTitleTable(
                                    subTitle:
                                        state.shopOrderList[index].user.name,
                                  ),
                                ),
                                Expanded(
                                  child: SubTitleTable(
                                    subTitle:
                                        "${state.shopOrderList[index].totalPrice} ر.س",
                                  ),
                                ),
                                Expanded(
                                  child: SubTitleTable(
                                    subTitle: state
                                        .shopOrderList[index].orderStatus
                                        .tr(context),
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
                  emptyListMessage: AppStrings.noOrder.tr(context),
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
