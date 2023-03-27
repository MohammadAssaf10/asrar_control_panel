import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/routes_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../blocs/service_order/service_order_bloc.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_view.dart';
import '../../widgets/service_order_view.dart';

class ServiceOrderScreen extends StatelessWidget {
  const ServiceOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ServiceOrderBloc, ServiceOrderState>(
        builder: (context, state) {
          if (state.serviceOrderStatus == ServiceOrderStatus.loading) {
            return LoadingView(
              height: AppSize.s550.h,
              width: double.infinity,
            );
          } else if (state.serviceOrderStatus == ServiceOrderStatus.error) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              height: AppSize.s550.h,
              width: double.infinity,
            );
          } else if (state.serviceOrderStatus == ServiceOrderStatus.loaded) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.serviceOrderList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    BlocProvider.of<ServiceOrderBloc>(context).add(
                        GetServiceOrderChat(
                            serviceOrderId: state.serviceOrderList[index].id));
                    Navigator.pushNamed(context, Routes.serviceOrderChatRoute,
                        arguments: state.serviceOrderList[index]);
                  },
                  child: ServiceOrderView(
                      serviceOrder: state.serviceOrderList[index]),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
