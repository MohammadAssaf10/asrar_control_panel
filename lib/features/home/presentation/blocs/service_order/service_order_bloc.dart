import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../../chat/domain/entities/message.dart';
import '../../../domain/entities/service_order.dart';
import '../../../domain/repositories/service_repository.dart';

part 'service_order_event.dart';

part 'service_order_state.dart';

class ServiceOrderBloc extends Bloc<ServiceOrderEvent, ServiceOrderState> {
  final ServiceRepository serviceRepository = instance<ServiceRepository>();
  StreamSubscription? messageStream;

  ServiceOrderBloc() : super(const ServiceOrderState()) {
    on<GetServiceOrder>((event, emit) async {
      emit(state.copyWith(serviceOrderStatus: ServiceOrderStatus.loading));
      (await serviceRepository.getServiceOrder()).fold((failure) {
        emit(state.copyWith(
            errorMessage: failure.message,
            serviceOrderStatus: ServiceOrderStatus.error));
      }, (serviceOrderList) {
        emit(state.copyWith(
            serviceOrderStatus: ServiceOrderStatus.loaded,
            serviceOrderList: serviceOrderList));
      });
    });
    on<GetServiceOrderChat>((event, emit) async {
      emit(state.copyWith(serviceOrderChatStatus: ServiceOrderStatus.loading));
      (await serviceRepository.getServiceOrderChat(event.serviceOrderId)).fold(
          (failure) {
        emit(state.copyWith(
            errorMessage: failure.message,
            serviceOrderChatStatus: ServiceOrderStatus.error));
      }, (r) {
        messageStream = r.listen((event) {
          add(_MessageReserved(messageList: event));
        });
      });
    });
    on<_MessageReserved>(
      (event, emit) {
        final list = event.messageList;
        list.sort((a, b) => b.details.createdAt.compareTo(a.details.createdAt));
        emit(state.copyWith(
            messages: list, serviceOrderChatStatus: ServiceOrderStatus.loaded));
      },
    );
  }
}
