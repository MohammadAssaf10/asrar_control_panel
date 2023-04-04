import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/message.dart';
import '../bloc/support_chat/support_chat_bloc.dart';
import '../function/function.dart';
import '../widgets/chat_bottom_widget.dart';
import '../widgets/message_widget.dart';

class SupportChatScreen extends StatelessWidget {
  SupportChatScreen({super.key, required this.sender});

  final Sender sender;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<SupportChatBloc, SupportChatState>(
              builder: (context, state) {
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: state.messagesList.length,
                  itemBuilder: (context, index) {
                    var isMine =
                        sender.id == state.messagesList[index].details.sender.id
                            ? false
                            : true;
                    return Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!isMine) const SizedBox(),
                        MessageWidget(
                          message: state.messagesList[index],
                          isMine: isMine,
                          isPreviousFromTheSameSender:
                              isPreviousFromTheSameSender(
                                  state.messagesList, index),
                        ),
                        if (isMine) const SizedBox(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          ChatBottom(
              sender: sender,
              onSended: () {
                _scrollController.animateTo(
                    _scrollController.position.minScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              }),
        ],
      ),
    );
  }
}
