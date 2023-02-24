import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../blocs/product/product_bloc.dart';
import '../../widgets/empty_list_view.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_view.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<ProductBloc, ProductState>(
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
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return LoadingView(
              height: AppSize.s550.h,
              width: double.infinity,
            );
          } else if (state is GetProductErrorState) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              height: AppSize.s550.h,
              width: double.infinity,
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
                        borderRadius: BorderRadius.circular(AppSize.s10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s10.r),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    state.productsList[index].productImageUrl,
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
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSize.s4.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    "${state.productsList[index].productPrice} ر.س",
                                    textDirection: TextDirection.rtl,
                                    style: getAlmaraiRegularStyle(
                                      fontSize: AppSize.s18.sp,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<ProductBloc>(context).add(
                                DeleteProductEvent(
                                  productEntities: state.productsList[index],
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
              return EmptyListView(
                emptyListMessage: AppStrings.noPictures.tr(context),
                height: AppSize.s550.h,
                width: double.infinity,
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
