part of 'shop_order_bloc.dart';

abstract class ShopOrderEvent extends Equatable {
  const ShopOrderEvent();
}

class UpdateShopOrderStatusEvent extends ShopOrderEvent {
  final ShopOrderEntities shopOrder;
  final OrderStatus newStatus;
  const UpdateShopOrderStatusEvent(
      {required this.shopOrder, required this.newStatus});
  @override
  List<Object?> get props => [shopOrder, newStatus];
}

class GetShopOrderEvent extends ShopOrderEvent {
  @override
  List<Object?> get props => [];
}
