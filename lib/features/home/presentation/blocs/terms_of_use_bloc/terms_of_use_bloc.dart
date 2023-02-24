import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/repositories/terms_of_use_repository.dart';

part 'terms_of_use_event.dart';
part 'terms_of_use_state.dart';

class TermsOfUseBloc extends Bloc<TermsOfUseEvent, TermsOfUseState> {
  final TermsOfUseRepository termsOfUseRepository =
      instance<TermsOfUseRepository>();
  TermsOfUseBloc() : super(const TermsOfUseState()) {
    on<GetTermsOfUseEvent>((event, emit) async {
      emit(state.copyWith(status: TermsOfUseStatus.loading));
      (await termsOfUseRepository.getTermsOfUse()).fold((failure) {
        emit(state.copyWith(
            errorMessage: failure.message, status: TermsOfUseStatus.error));
      }, (termOfUse) {
        emit(state.copyWith(
            termsOfUse: termOfUse, status: TermsOfUseStatus.loaded));
      });
    });
    on<AddTermsOfUseEvent>((event, emit) async {
      emit(state.copyWith(status: TermsOfUseStatus.loading));
      (await termsOfUseRepository.addTermsOfUse(event.termsOfUse)).fold(
          (failure) {
        emit(state.copyWith(
            errorMessage: failure.message, status: TermsOfUseStatus.error));
      }, (r) {
        emit(state.copyWith(status: TermsOfUseStatus.added));
      });
    });
    on<UpdateTermsOfUseEvent>((event, emit) async {
      emit(state.copyWith(status: TermsOfUseStatus.updateLoading));
      (await termsOfUseRepository.updateTermsOfUse(event.termsOfUse)).fold(
          (failure) {
        emit(state.copyWith(
            errorMessage: failure.message,
            status: TermsOfUseStatus.updateError));
      }, (r) {
        emit(state.copyWith(status: TermsOfUseStatus.updated));
      });
    });
  }
}
