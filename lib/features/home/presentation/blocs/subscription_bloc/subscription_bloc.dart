import 'package:asrar_control_panel/features/home/presentation/blocs/subscription_bloc/subscription_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/subscription_entities.dart';
import '../../../domain/repositories/subscription_repository.dart';

part 'subscription_event.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository subscriptionRepository =
      instance<SubscriptionRepository>();
  SubscriptionBloc() : super(const SubscriptionState()) {
    on<AddSubscriptionEvent>((event, emit) async {
      emit(state.copyWith(
          subscriptionStatus: SubscriptionStatus.subscriptionLoading));
      (await subscriptionRepository.addSubscription(event.subscription)).fold(
          (failure) {
        emit(
          state.copyWith(
              subscriptionStatus: SubscriptionStatus.subscriptionError,
              errorMessage: failure.message),
        );
      }, (r) {
        emit(
          state.copyWith(
              subscriptionStatus: SubscriptionStatus.subscriptionAdded),
        );
      });
    });
    on<DeleteSubscriptionEvent>((event, emit) async {
      emit(
        state.copyWith(
          subscriptionStatus: SubscriptionStatus.deleteSubscriptionLoading,
        ),
      );
      (await subscriptionRepository.deleteSubscription(event.subscription))
          .fold((failure) {
        emit(
          state.copyWith(
              subscriptionStatus: SubscriptionStatus.subscriptionError,
              errorMessage: failure.message),
        );
      }, (r) {
        emit(
          state.copyWith(
              subscriptionStatus: SubscriptionStatus.subscriptionDeleted),
        );
      });
    });
    on<GetSubscriptionsListEvent>((event, emit) async {
      emit(state.copyWith(
          subscriptionStatus: SubscriptionStatus.subscriptionLoading));
      (await subscriptionRepository.getSubscriptionsList()).fold((failure) {
        emit(
          state.copyWith(
              subscriptionStatus: SubscriptionStatus.subscriptionLoadedError,
              errorMessage: failure.message),
        );
      }, (subscriptionList) {
        emit(
          state.copyWith(
              subscriptionList: subscriptionList,
              subscriptionStatus: SubscriptionStatus.subscriptionLoaded),
        );
      });
    });
  }
}
