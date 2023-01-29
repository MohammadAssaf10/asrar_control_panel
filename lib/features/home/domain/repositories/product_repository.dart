import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/product_entities.dart';

abstract class ProductRepository {
  Future<Either<Failure, Unit>> addProduct(
    ProductEntities product,
    String productImageUrl,
  );
  Future<Either<Failure, List<ProductEntities>>> getProductsList();
  Future<Either<Failure, Unit>> deleteProduct(ProductEntities product);
}
