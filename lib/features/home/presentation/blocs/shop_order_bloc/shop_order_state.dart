part of 'shop_order_bloc.dart';

abstract class ShopOrderState extends Equatable {
  const ShopOrderState();
}

class ShopOrderInitial extends ShopOrderState {
  @override
  List<Object?> get props => [];
}

class ShopOrderLoadingState extends ShopOrderState {
  @override
  List<Object?> get props => [];
}

class UpdateShopOrderStatusLoadingState extends ShopOrderState {
  @override
  List<Object?> get props => [];
}

class ShopOrderErrorState extends ShopOrderState {
  final String errorMessage;
  const ShopOrderErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class UpdateShopOrderStatusErrorState extends ShopOrderState {
  final String errorMessage;
  const UpdateShopOrderStatusErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class ShopOrderLoadedState extends ShopOrderState {
  final List<ShopOrderEntities> shopOrderList;
  const ShopOrderLoadedState({required this.shopOrderList});
  @override
  List<Object?> get props => [shopOrderList];
}

class UpdateShopOrderStatusSuccessfullyState extends ShopOrderState {
  @override
  List<Object?> get props => [];
}
