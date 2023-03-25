import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../blocs/job_bloc/job_bloc.dart';
import '../../widgets/empty_list_view.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_view.dart';

class DeleteJobScreen extends StatelessWidget {
  const DeleteJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<JobBloc, JobState>(
        listener: (context, state) {
          if (state is DeleteJobLoadingState) {
            showCustomDialog(context);
          } else if (state is JobErrorState) {
            showCustomDialog(context, message: state.errorMessage);
            BlocProvider.of<JobBloc>(context).add(GetJobsListEvent());
          } else if (state is JobDeletedSuccessfullyState) {
            showCustomDialog(context,
                message: AppStrings.deletedSuccessfully.tr(context));
            BlocProvider.of<JobBloc>(context).add(GetJobsListEvent());
          }
        },
        builder: (context, state) {
          if (state is JobLoadingState) {
            return LoadingView(
              height: AppSize.s550.h,
              width: double.infinity,
            );
          } else if (state is GetJobErrorState) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              height: AppSize.s550.h,
              width: double.infinity,
            );
          } else if (state is JobsLoadedState) {
            if (state.jobsList.isNotEmpty) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.jobsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: AppSize.s80.h,
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
                                    state.jobsList[index].jobImageUrl,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    state.jobsList[index].jobTitle,
                                    style: getAlmaraiRegularStyle(
                                      fontSize: AppSize.s18.sp,
                                      color: ColorManager.white,
                                    ),
                                    maxLines: 3,
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                  Text(
                                    state.jobsList[index].timestamp
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
                              BlocProvider.of<JobBloc>(context).add(
                                DeleteJobEvent(
                                  job: state.jobsList[index],
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
                emptyListMessage: AppStrings.noJobs.tr(context),
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
