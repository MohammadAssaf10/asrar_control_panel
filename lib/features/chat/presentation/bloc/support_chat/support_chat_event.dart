part of 'support_chat_bloc.dart';

abstract class SupportChatEvent extends Equatable {
  const SupportChatEvent();
}

class ChatEnded extends SupportChatEvent {
  @override
  List<Object?> get props => [];
}

class GetSender extends SupportChatEvent {
  @override
  List<Object?> get props => [];
}

class TextMessageSent extends SupportChatEvent {
  final TextMessage message;
  final String docId;
  const TextMessageSent({required this.message,required this.docId});

  @override
  List<Object?> get props => [message];
}

class ImageMessageSent extends SupportChatEvent {
  final ImageMessage message;
  final XFile image;
  final String docId;

  const ImageMessageSent(this.image, this.message,{required this.docId});

  @override
  List<Object?> get props => [image, message,docId];
}

class _MessageReserved extends SupportChatEvent {
  final List<Message> messageList;

  const _MessageReserved({
    required this.messageList,
  });

  @override
  List<Object?> get props => [messageList];
}

class GetSupportChat extends SupportChatEvent {
  final String senderId;

  const GetSupportChat({required this.senderId});

  @override
  List<Object?> get props => [senderId];
}
