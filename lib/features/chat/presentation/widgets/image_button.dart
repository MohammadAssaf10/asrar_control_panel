import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../domain/entities/message.dart';
import '../bloc/support_chat/support_chat_bloc.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    Key? key,
    required this.onSended,
    required this.sender,
  }) : super(key: key);

  final Function? onSended;
  final Sender sender;

  @override
  Widget build(BuildContext context) {
    var authUser = BlocProvider
        .of<AuthenticationBloc>(context)
        .state;
    if (authUser is AuthenticationSuccess) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
            onTap: () async {
              onSended;
              XFile? image = await selectFile(context);
              if (image != null) {
                final Sender imageSender = Sender(
                    id: authUser.employee.employeeID,
                    name: authUser.employee.name,
                    email: authUser.employee.email);
                BlocProvider.of<SupportChatBloc>(context).add(ImageMessageSent(
                    image, ImageMessage.create(imageSender),
                    docId: sender.id));
              }
            },
            child: const Icon(
              Icons.camera_alt,
              color: ColorManager.primary,
            )),
      );
    }
    return const SizedBox();
  }
}
