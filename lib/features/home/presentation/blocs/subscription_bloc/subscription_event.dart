part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();
}

class AddSubscriptionEvent extends SubscriptionEvent {
  final SubscriptionEntities subscription;
  const AddSubscriptionEvent({required this.subscription});
  @override
  List<Object?> get props => [subscription];
}

class DeleteSubscriptionEvent extends SubscriptionEvent {
  final SubscriptionEntities subscription;
  const DeleteSubscriptionEvent({required this.subscription});

  @override
  List<Object?> get props => [subscription];
}

class GetSubscriptionsListEvent extends SubscriptionEvent {
  @override
  List<Object?> get props => [];
}
