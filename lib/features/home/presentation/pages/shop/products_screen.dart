import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../blocs/product/bloc/product_bloc.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is DeleteProductLoadingState) {
              showCustomDialog(context);
            } else if (state is ProductErrorState) {
              showCustomDialog(context, message: state.errorMessage);
              BlocProvider.of<ProductBloc>(context).add(GetProductsListEvent());
            } else if (state is ProductDeletedSuccessfullyState) {
              showCustomDialog(context,
                  message: AppStrings.deletedSuccessfully.tr(context));
              BlocProvider.of<ProductBloc>(context).add(GetProductsListEvent());
            }
          },
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                  ),
                );
              } else if (state is GetProductErrorState) {
                return Center(
                  child: Text(
                    state.errorMessage.tr(context),
                    style: getAlmaraiRegularStyle(
                      fontSize: AppSize.s20.sp,
                      color: ColorManager.error,
                    ),
                  ),
                );
              } else if (state is ProductsLoadedState) {
                if (state.productsList.isNotEmpty) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.productsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: AppSize.s75.h,
                          margin: EdgeInsets.symmetric(
                            vertical: AppSize.s10.h,
                            horizontal: AppSize.s120.w,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(AppSize.s20.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s20.r),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        state.productsList[index]
                                            .productImageUrl,
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
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppSize.s10.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        state.productsList[index].productName,
                                        style: getAlmaraiRegularStyle(
                                          fontSize: AppSize.s18.sp,
                                          color: ColorManager.white,
                                        ),
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                      ),
                                      Text(
                                        state.productsList[index].productPrice,
                                        style: getAlmaraiRegularStyle(
                                          fontSize: AppSize.s18.sp,
                                          color: ColorManager.white,
                                        ),
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<ProductBloc>(context).add(
                                    DeleteProductEvent(
                                      productEntities:
                                          state.productsList[index],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              )
                            ],
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: Text(
                      AppStrings.noProducts.tr(context),
                      style: getAlmaraiRegularStyle(
                        fontSize: AppSize.s25.sp,
                        color: ColorManager.primary,
                      ),
                    ),
                  );
                }
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
