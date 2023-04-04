import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../domain/entities/message.dart';
import '../bloc/support_chat/support_chat_bloc.dart';

class ChatTextField extends StatelessWidget {
  ChatTextField({super.key, this.onSended, required this.docId});

  final TextEditingController _chatController = TextEditingController();

  final String docId;
  final Function? onSended;

  @override
  Widget build(BuildContext context) {
    var authUser = BlocProvider.of<AuthenticationBloc>(context).state;
    if (authUser is AuthenticationSuccess) {
      Sender employeeSender = Sender(
          id: authUser.employee.employeeID,
          name: authUser.employee.name,
          email: authUser.employee.email);
      return Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          border: Border.all(color: ColorManager.grey),
          borderRadius: BorderRadius.circular(AppSize.s15.r),
        ),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  if (onSended != null) onSended!();
                  if (_chatController.text.isNotEmpty) {
                    BlocProvider.of<SupportChatBloc>(context).add(
                        TextMessageSent(
                            docId: docId,
                            message: TextMessage.create(
                                _chatController.text, employeeSender)));
                    _chatController.clear();
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: ColorManager.primary,
                )),
            Expanded(
              child: TextField(
                controller: _chatController,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  // focused border style
                  focusedBorder: InputBorder.none,
                  // error border style
                  errorBorder: InputBorder.none,
                  // focused error border style
                  focusedErrorBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
