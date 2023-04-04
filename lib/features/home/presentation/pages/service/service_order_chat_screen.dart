import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/values_manager.dart';
import '../../../../chat/presentation/function/function.dart';
import '../../../domain/entities/service_order.dart';
import '../../blocs/service_order/service_order_bloc.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_view.dart';
import '../../../../chat/presentation/widgets/message_widget.dart';

class ServiceOrderChatScreen extends StatelessWidget {
  ServiceOrderChatScreen({super.key, required this.serviceOrder});

  final ServiceOrder serviceOrder;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ServiceOrderBloc, ServiceOrderState>(
              builder: (context, state) {
                if (state.serviceOrderChatStatus ==
                    ServiceOrderStatus.loading) {
                  return LoadingView(
                    height: AppSize.s550.h,
                    width: double.infinity,
                  );
                } else if (state.serviceOrderChatStatus ==
                    ServiceOrderStatus.error) {
                  return ErrorView(
                    errorMessage: state.errorMessage.tr(context),
                    height: AppSize.s550.h,
                    width: double.infinity,
                  );
                } else if (state.serviceOrderChatStatus ==
                    ServiceOrderStatus.loaded) {
                  final String id = state.messages.first.details.sender.id;
                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      bool isMine =
                          state.messages[index].details.sender.id == id
                              ? true
                              : false;
                      return Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!isMine) const SizedBox(),
                          MessageWidget(
                            message: state.messages[index],
                            isMine: isMine,
                            isPreviousFromTheSameSender:
                                isPreviousFromTheSameSender(
                                    state.messages, index),
                          ),
                          if (isMine) const SizedBox(),
                        ],
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
