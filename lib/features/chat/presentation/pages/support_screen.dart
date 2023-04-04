import 'package:asrar_control_panel/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/di.dart';
import '../../../employees_manager/presentation/employee_management_bloc/employee_management_bloc.dart';
import '../../../home/presentation/widgets/error_view.dart';
import '../../../home/presentation/widgets/loading_view.dart';
import '../bloc/support_chat/support_chat_bloc.dart';
import '../widgets/sender_view.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SupportChatBloc, SupportChatState>(
        builder: (context, state) {
          if (state.senderStatus == Status.loading) {
            return LoadingView(
              height: AppSize.s550.h,
              width: double.infinity,
            );
          } else if (state.senderStatus == Status.failed) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              height: AppSize.s550.h,
              width: double.infinity,
            );
          } else if (state.senderStatus == Status.success) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.senderList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      initSupportChatModule(state.senderList[index]);
                      BlocProvider.of<SupportChatBloc>(context).add(
                          GetSupportChat(senderId: state.senderList[index].id));
                      Navigator.pushNamed(context, Routes.supportChatRoute,
                          arguments: state.senderList[index]);
                    },
                    child: SenderView(sender: state.senderList[index]),
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
