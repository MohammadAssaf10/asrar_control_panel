import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/values_manager.dart';
import '../../domain/entities/message.dart';
import 'chat_text_field.dart';
import 'image_button.dart';

class ChatBottom extends StatefulWidget {
  const ChatBottom({super.key, this.onSended, required this.sender});

  final Function? onSended;
  final Sender sender;

  @override
  State<ChatBottom> createState() => _ChatBottomState();
}

class _ChatBottomState extends State<ChatBottom> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            left: AppSize.s10.w,
            top: AppSize.s10.w,
            right: AppSize.s10.w,
            bottom: AppSize.s15.h),
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageButton(onSended: widget.onSended, sender: widget.sender),
            Expanded(
                child: ChatTextField(
              onSended: widget.onSended,
              docId: widget.sender.id,
            )),
          ],
        ),
      ),
    );
  }
}
