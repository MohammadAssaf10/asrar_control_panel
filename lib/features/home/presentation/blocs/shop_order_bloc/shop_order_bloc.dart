import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/constants.dart';
import '../../../../../core/app/di.dart';
import '../../../domain/entities/shop_order_entities.dart';
import '../../../domain/repositories/shop_repository.dart';

part 'shop_order_event.dart';
part 'shop_order_state.dart';

class ShopOrderBloc extends Bloc<ShopOrderEvent, ShopOrderState> {
  final ShopRepository shopRepository = instance<ShopRepository>();
  ShopOrderBloc() : super(ShopOrderInitial()) {
    on<GetShopOrderEvent>((event, emit) async {
      emit(ShopOrderLoadingState());
      (await shopRepository.getShopOrder()).fold((failure) {
        emit(ShopOrderErrorState(errorMessage: failure.message));
      }, (shopOrderList) {
        emit(ShopOrderLoadedState(shopOrderList: shopOrderList));
      });
    });
    on<UpdateShopOrderStatusEvent>((event, emit) async {
      emit(UpdateShopOrderStatusLoadingState());
      (await shopRepository.updateShopOrderStatus(
              event.shopOrder, event.newStatus))
          .fold((failure) {
        emit(UpdateShopOrderStatusErrorState(errorMessage: failure.message));
      }, (r) {
        emit(UpdateShopOrderStatusSuccessfullyState());
      });
    });
  }
}
