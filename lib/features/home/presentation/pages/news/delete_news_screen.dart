import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../blocs/news_bloc/news_bloc.dart';
import '../../widgets/empty_list_view.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_view.dart';

class DeleteNewsScreen extends StatelessWidget {
  const DeleteNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<NewsBloc, NewsState>(
        listener: (context, state) {
          if (state is DeleteNewsLoadingState) {
            showCustomDialog(context);
          } else if (state is NewsErrorState) {
            showCustomDialog(context, message: state.errorMessage);
            BlocProvider.of<NewsBloc>(context).add(GetNewsListEvent());
          } else if (state is NewsDeletedSuccessfullyState) {
            showCustomDialog(context,
                message: AppStrings.deletedSuccessfully.tr(context));
            BlocProvider.of<NewsBloc>(context).add(GetNewsListEvent());
          }
        },
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoadingState) {
              return LoadingView(
                height: AppSize.s550.h,
                width: double.infinity,
              );
            } else if (state is GetNewsErrorState) {
              return ErrorView(
                errorMessage: state.errorMessage.tr(context),
                height: AppSize.s550.h,
                width: double.infinity,
              );
            } else if (state is NewsLoadedState) {
              if (state.newsList.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.newsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Container(
                          height: AppSize.s80.h,
                          width: AppSize.s120.w,
                          margin: EdgeInsets.symmetric(
                            vertical: AppSize.s10.h,
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
                                        state.newsList[index].newsImageUrl,
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
                                    horizontal: AppSize.s5.w,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        state.newsList[index].newsTitle,
                                        style: getAlmaraiRegularStyle(
                                          fontSize: AppSize.s18.sp,
                                          color: ColorManager.white,
                                        ),
                                        maxLines: 3,
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                      ),
                                      Text(
                                        state.newsList[index].timestamp
                                            .toDate()
                                            .toString(),
                                        style: getAlmaraiRegularStyle(
                                          fontSize: AppSize.s15.sp,
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
                                  BlocProvider.of<NewsBloc>(context).add(
                                    DeleteNewsEvent(
                                      news: state.newsList[index],
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
                  emptyListMessage: AppStrings.noNews.tr(context),
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
