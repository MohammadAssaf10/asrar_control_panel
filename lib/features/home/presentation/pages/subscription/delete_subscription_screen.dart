import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../blocs/subscription_bloc/subscription_bloc.dart';
import '../../blocs/subscription_bloc/subscription_state.dart';
import '../../widgets/empty_list_view.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_view.dart';

class DeleteSubscriptionScreen extends StatelessWidget {
  const DeleteSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocConsumer<SubscriptionBloc, SubscriptionState>(
          listener: (context, state) {
            if (state.subscriptionStatus ==
                SubscriptionStatus.deleteSubscriptionLoading) {
              showCustomDialog(context);
            } else if (state.subscriptionStatus ==
                SubscriptionStatus.subscriptionError) {
              showCustomDialog(context, message: state.errorMessage);
              BlocProvider.of<SubscriptionBloc>(context)
                  .add(GetSubscriptionsListEvent());
            } else if (state.subscriptionStatus ==
                SubscriptionStatus.subscriptionDeleted) {
              showCustomDialog(context,
                  message: AppStrings.deletedSuccessfully.tr(context));
              BlocProvider.of<SubscriptionBloc>(context)
                  .add(GetSubscriptionsListEvent());
            }
          },
          builder: (context, state) {
            if (state.subscriptionStatus ==
                SubscriptionStatus.subscriptionLoading) {
              return LoadingView(
                height: AppSize.s550.h,
                width: double.infinity,
              );
            } else if (state.subscriptionStatus ==
                SubscriptionStatus.subscriptionLoadedError) {
              return ErrorView(
                errorMessage: state.errorMessage.tr(context),
                height: AppSize.s550.h,
                width: double.infinity,
              );
            } else if (state.subscriptionStatus ==
                SubscriptionStatus.subscriptionLoaded) {
              if (state.subscriptionList.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.subscriptionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Container(
                          height: AppSize.s60.h,
                          width: AppSize.s120.w,
                          margin: EdgeInsets.symmetric(
                            vertical: AppSize.s10.h,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: AppSize.s10.h,
                            horizontal: AppSize.s2.w,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      state.subscriptionList[index]
                                          .subscriptionName,
                                      style: getAlmaraiRegularStyle(
                                        fontSize: AppSize.s18.sp,
                                        color: ColorManager.white,
                                      ),
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Visibility(
                                      visible: state.subscriptionList[index]
                                                  .subscriptionPrice ==
                                              ""
                                          ? false
                                          : true,
                                      child: Text(
                                        state.subscriptionList[index]
                                                .subscriptionPrice
                                                .startsWith("0")
                                            ? AppStrings.free.tr(context)
                                            : "${state.subscriptionList[index].subscriptionPrice} ر.س",
                                        textDirection: TextDirection.rtl,
                                        style: getAlmaraiRegularStyle(
                                          fontSize: AppSize.s16.sp,
                                          color: ColorManager.white,
                                        ),
                                      ),
                                    ),
                                    // Text(
                                    //   state.subscriptionList[index]
                                    //           .subscriptionPrice
                                    //           .startsWith("0")
                                    //       ? "مجاناً"
                                    //       : state.subscriptionList[index]
                                    //                   .subscriptionPrice ==
                                    //               ""
                                    //           ? ""
                                    //           : "${state.subscriptionList[index]
                                    //               .subscriptionPrice} ر.س",
                                    //   style: getAlmaraiRegularStyle(
                                    //     fontSize: AppSize.s16.sp,
                                    //     color: ColorManager.white,
                                    //   ),
                                    //   maxLines: 1,
                                    //   softWrap: true,
                                    //   overflow: TextOverflow.visible,
                                    // ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<SubscriptionBloc>(context)
                                      .add(
                                    DeleteSubscriptionEvent(
                                      subscription:
                                          state.subscriptionList[index],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return EmptyListView(
                  emptyListMessage: AppStrings.noSubscriptions.tr(context),
                  height: AppSize.s550.h,
                  width: double.infinity,
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
