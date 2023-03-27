part of 'service_order_bloc.dart';

abstract class ServiceOrderEvent extends Equatable {
  const ServiceOrderEvent();
}

class GetServiceOrder extends ServiceOrderEvent {
  @override
  List<Object?> get props => [];
}

class GetServiceOrderChat extends ServiceOrderEvent {
  final int serviceOrderId;

  const GetServiceOrderChat({required this.serviceOrderId});

  @override
  List<Object?> get props => [serviceOrderId];
}

class _MessageReserved extends ServiceOrderEvent {
  final List<Message> messageList;

  const _MessageReserved({
    required this.messageList,
  });

  @override
  List<Object?> get props => [messageList];
}
