part of 'service_order_bloc.dart';

enum ServiceOrderStatus { initial, loading, error, loaded }

class ServiceOrderState extends Equatable {
  final String errorMessage;
  final ServiceOrderStatus serviceOrderStatus;
  final ServiceOrderStatus serviceOrderChatStatus;
  final List<ServiceOrder> serviceOrderList;
  final List<Message> messages;

  const ServiceOrderState({
    this.serviceOrderList = const [],
    this.messages = const [],
    this.errorMessage = '',
    this.serviceOrderStatus = ServiceOrderStatus.initial,
    this.serviceOrderChatStatus = ServiceOrderStatus.initial,
  });

  @override
  List<Object?> get props => [
        errorMessage,
        serviceOrderList,
        serviceOrderStatus,
        serviceOrderChatStatus,
        messages
      ];

  ServiceOrderState copyWith({
    String? errorMessage,
    ServiceOrderStatus? serviceOrderStatus,
    ServiceOrderStatus? serviceOrderChatStatus,
    List<ServiceOrder>? serviceOrderList,
    List<Message>? messages,
  }) {
    return ServiceOrderState(
      errorMessage: errorMessage ?? this.errorMessage,
      serviceOrderList: serviceOrderList ?? this.serviceOrderList,
      serviceOrderStatus: serviceOrderStatus ?? this.serviceOrderStatus,
      serviceOrderChatStatus:
          serviceOrderChatStatus ?? this.serviceOrderChatStatus,
      messages: messages ?? this.messages,
    );
  }
}
