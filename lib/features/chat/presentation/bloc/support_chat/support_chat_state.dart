part of 'support_chat_bloc.dart';

class SupportChatState extends Equatable {
  final Status status;
  final Status senderStatus;
  final Status supportChatStatus;
  final Status fileUploadingStatus;
  final List<Message> messagesList;
  final String? message;
  final List<Sender> senderList;
  final String errorMessage;

  const SupportChatState(
    this.status,
    this.senderStatus,
    this.supportChatStatus,
    this.messagesList,
    this.senderList,
    this.message,
    this.fileUploadingStatus,
    this.errorMessage,
  );

  SupportChatState.init()
      : messagesList = [],
        senderList = [],
        message = null,
        status = Status.init,
        senderStatus = Status.init,
        supportChatStatus = Status.init,
        errorMessage = '',
        fileUploadingStatus = Status.init;

  @override
  List<Object> get props => [
        status,
        messagesList,
        message ?? '',
        fileUploadingStatus,
        senderStatus,
        senderList,
        errorMessage,
        supportChatStatus
      ];

  SupportChatState copyWith({
    Status? status,
    Status? senderStatus,
    Status? supportChatStatus,
    Status? fileUploadingStatus,
    List<Message>? messagesList,
    List<Sender>? senderList,
    String? message,
    String? errorMessage,
  }) {
    return SupportChatState(
      status ?? this.status,
      senderStatus ?? this.senderStatus,
      supportChatStatus ?? this.supportChatStatus,
      messagesList ?? this.messagesList,
      senderList ?? this.senderList,
      message,
      fileUploadingStatus ?? this.fileUploadingStatus,
      errorMessage ?? this.errorMessage,
    );
  }
}
