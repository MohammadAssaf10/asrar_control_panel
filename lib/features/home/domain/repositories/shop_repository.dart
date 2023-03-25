import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/failure.dart';
import '../entities/product_entities.dart';
import '../entities/shop_order_entities.dart';

abstract class ShopRepository {
  Future<Either<Failure, Unit>> addProduct(
    ProductEntities product,
    String productImageUrl,
  );
  Future<Either<Failure, List<ProductEntities>>> getProductsList();
  Future<Either<Failure, Unit>> deleteProduct(ProductEntities product);
  Future<Either<Failure, List<ShopOrderEntities>>> getShopOrder();
  Future<Either<Failure, Unit>> updateShopOrderStatus(
    ShopOrderEntities shopOrder,
    OrderStatus newStatus,
  );
}
