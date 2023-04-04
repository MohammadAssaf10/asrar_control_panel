import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/app/di.dart';
import '../../../../employees_manager/presentation/employee_management_bloc/employee_management_bloc.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/repository/support_chat_repository.dart';

part 'support_chat_event.dart';

part 'support_chat_state.dart';

class SupportChatBloc extends Bloc<SupportChatEvent, SupportChatState> {
  final SupportChatRepository _chatRepository =
      instance<SupportChatRepository>();
  StreamSubscription? _messageStream;

  SupportChatBloc() : super(SupportChatState.init()) {
    on<_MessageReserved>((event, emit) {
      final list = event.messageList;
      list.sort((a, b) => b.details.createdAt.compareTo(a.details.createdAt));
      emit(state.copyWith(
          supportChatStatus: Status.success, messagesList: list));
    });

    on<GetSupportChat>((event, emit) async {
      emit(state.copyWith(supportChatStatus: Status.loading));
      (await _chatRepository.getSupportChat(event.senderId)).fold((failure) {
        emit(state.copyWith(
            supportChatStatus: Status.failed, errorMessage: failure.message));
      }, (r) {
        _messageStream = r.listen((messagesList) {
          add(_MessageReserved(messageList: messagesList));
        });
      });
    });

    on<TextMessageSent>((event, emit) async {
      (await _chatRepository.sendMessage(event.message,event.docId)).fold(
        (l) {
          emit(state.copyWith(status: Status.failed, message: l.message));
        },
        (r) {},
      );
    });

    on<ImageMessageSent>(
      (event, emit) async {
        emit(state.copyWith(fileUploadingStatus: Status.loading));
        await (await _chatRepository.uploadImage(event.image)).fold(
          (l) {
            emit(state.copyWith(
                fileUploadingStatus: Status.failed, message: l.message));
          },
          (r) async {
            emit(state.copyWith(fileUploadingStatus: Status.success));

            var imageMessage = event.message.copyWith(imageUrl: r);
            (await _chatRepository.sendMessage(imageMessage,event.docId)).fold(
              (l) {
                emit(state.copyWith(status: Status.failed, message: l.message));
              },
              (r) {},
            );
          },
        );
      },
    );

    on<GetSender>((event, emit) async {
      emit(state.copyWith(senderStatus: Status.loading));
      (await _chatRepository.getSender()).fold((failure) {
        emit(state.copyWith(
            senderStatus: Status.failed, errorMessage: failure.message));
      }, (senderList) {
        emit(state.copyWith(
            senderStatus: Status.success, senderList: senderList));
      });
    });

    on<ChatEnded>((event, emit) {
      _messageStream?.cancel();
    });
  }

  @override
  Future<void> close() {
    _messageStream?.cancel();
    return super.close();
  }
}
