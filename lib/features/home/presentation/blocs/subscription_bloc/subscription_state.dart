import 'package:equatable/equatable.dart';

import '../../../domain/entities/subscription_entities.dart';

enum SubscriptionStatus {
  subscriptionLoading,
  subscriptionError,
  subscriptionLoaded,
  subscriptionAdded,
  subscriptionDeleted,
  deleteSubscriptionLoading,
  subscriptionLoadedError,
}

class SubscriptionState extends Equatable {
  final SubscriptionStatus subscriptionStatus;
  final List<SubscriptionEntities> subscriptionList;
  final String errorMessage;
  const SubscriptionState({
    this.subscriptionStatus = SubscriptionStatus.subscriptionLoading,
    this.subscriptionList = const [],
    this.errorMessage = "",
  });

  @override
  List<Object> get props => [subscriptionStatus, subscriptionList];

  SubscriptionState copyWith({
    SubscriptionStatus? subscriptionStatus,
    List<SubscriptionEntities>? subscriptionList,
    String? errorMessage,
  }) {
    return SubscriptionState(
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      subscriptionList: subscriptionList ?? this.subscriptionList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'SubscriptionState(subscriptionStatus: $subscriptionStatus, subscriptionList: $subscriptionList, errorMessage: $errorMessage)';
}
