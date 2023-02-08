import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/subscription_entities.dart';

abstract class SubscriptionRepository {
  Future<Either<Failure, Unit>> addSubscription(
    SubscriptionEntities subscription,
  );
  Future<Either<Failure, List<SubscriptionEntities>>> getSubscriptionsList();
  Future<Either<Failure, Unit>> deleteSubscription(
    SubscriptionEntities subscription,
  );
}
