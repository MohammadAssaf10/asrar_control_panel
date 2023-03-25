import 'package:asrar_control_panel/features/home/domain/entities/shop_order_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/entities/product_entities.dart';
import '../../domain/repositories/shop_repository.dart';

class ShopRepositoryImpl extends ShopRepository {
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
        productCount: product.productCount,
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

  @override
  Future<Either<Failure, List<ShopOrderEntities>>> getShopOrder() async {
    try {
      List<ShopOrderEntities> shopOrderList = [];
      final shopOrders =
          await db.collection(FireBaseCollection.shopOrders).get();
      for (var doc in shopOrders.docs) {
        shopOrderList.add(ShopOrderEntities.fromMap(doc.data()));
      }
      shopOrderList.sort((a, b) => b.orderStatus.compareTo(a.orderStatus));
      return Right(shopOrderList);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> updateShopOrderStatus(
    ShopOrderEntities shopOrder,
    OrderStatus newStatus,
  ) async {
    try {
      await db
          .collection(FireBaseCollection.shopOrders)
          .doc(shopOrder.shopOrderId.toString())
          .update({"orderStatus": newStatus.name});
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
