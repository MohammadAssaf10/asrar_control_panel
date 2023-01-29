part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class AddProductEvent extends ProductEvent {
  final ProductEntities productEntities;
  final XFileEntities xFileEntities;
  const AddProductEvent({
    required this.productEntities,
    required this.xFileEntities,
  });
  @override
  List<Object?> get props => [productEntities, xFileEntities];
}

class GetProductsListEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class DeleteProductEvent extends ProductEvent {
  final ProductEntities productEntities;
  const DeleteProductEvent({required this.productEntities});

  @override
  List<Object?> get props => [productEntities];
}
