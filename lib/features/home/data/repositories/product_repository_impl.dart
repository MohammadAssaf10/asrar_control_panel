import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/entities/product_entities.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<Either<Failure, Unit>> addProduct(
      ProductEntities product, String productImageUrl) async {
    try {
      final Map<String, dynamic> productEntities = ProductEntities(
        productName: product.productName,
        productImageUrl: productImageUrl,
        productImageName: product.productImageName,
        productPrice: product.productPrice,
      ).toMap();
      await db
          .collection(FireBaseCollection.products)
          .doc(product.productName)
          .set(productEntities);
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<ProductEntities>>> getProductsList() async {
    try {
      List<ProductEntities> productsList = [];
      final products = await db.collection(FireBaseCollection.products).get();
      for (var doc in products.docs) {
        productsList.add(ProductEntities.fromMap(doc.data()));
      }
      return Right(productsList);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(ProductEntities product) async {
    try {
      await FirebaseStorage.instance
          .ref("${FireBaseCollection.products}/${product.productImageName}")
          .delete();
      await db
          .collection(FireBaseCollection.products)
          .doc(product.productName)
          .delete();
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
