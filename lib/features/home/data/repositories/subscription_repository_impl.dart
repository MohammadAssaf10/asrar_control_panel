import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/entities/subscription_entities.dart';
import '../../domain/repositories/subscription_repository.dart';

class SubscriptionRepositoryImpl extends SubscriptionRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<Either<Failure, Unit>> addSubscription(
      SubscriptionEntities subscription) async {
    try {
      final Map<String, dynamic> subscriptionEntities = SubscriptionEntities(
        subscriptionName: subscription.subscriptionName,
        subscriptionPrice: subscription.subscriptionPrice,
      ).toMap();
      await db
          .collection(FireBaseCollection.subscriptions)
          .doc(subscription.subscriptionName)
          .set(subscriptionEntities);
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSubscription(
      SubscriptionEntities subscription) async {
    try {
      await db
          .collection(FireBaseCollection.subscriptions)
          .doc(subscription.subscriptionName)
          .delete();
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionEntities>>>
      getSubscriptionsList() async {
    try {
      final List<SubscriptionEntities> subscriptionList = [];
      final subscriptions =
          await db.collection(FireBaseCollection.subscriptions).get();
      for (var doc in subscriptions.docs) {
        subscriptionList.add(SubscriptionEntities.fromMap(doc.data()));
      }
      return Right(subscriptionList);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
