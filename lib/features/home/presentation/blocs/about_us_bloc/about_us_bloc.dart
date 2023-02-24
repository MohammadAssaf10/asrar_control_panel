import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/repositories/about_us_repository.dart';

part 'about_us_event.dart';
part 'about_us_state.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  final AboutUsRepository aboutUsRepository = instance<AboutUsRepository>();
  AboutUsBloc() : super(const AboutUsState()) {
    on<GetAbuotUsEvent>((event, emit) async {
      emit(state.copyWith(status: AboutUsStatus.loading));
      (await aboutUsRepository.getAboutUs()).fold((failure) {
        emit(state.copyWith(
            errorMessage: failure.message, status: AboutUsStatus.error));
      }, (aboutUs) {
        emit(state.copyWith(aboutUs: aboutUs, status: AboutUsStatus.loaded));
      });
    });
    on<AddAbuotUsEvent>((event, emit) async {
      emit(state.copyWith(status: AboutUsStatus.loading));
      (await aboutUsRepository.addAboutUs(event.aboutUs)).fold((failure) {
        emit(state.copyWith(
            errorMessage: failure.message, status: AboutUsStatus.error));
      }, (r) {
        emit(state.copyWith(status: AboutUsStatus.added));
      });
    });
    on<UpdateAbuotUsEvent>((event, emit) async {
      emit(state.copyWith(status: AboutUsStatus.updateLoading));
      (await aboutUsRepository.updateAboutUs(event.aboutUs)).fold((failure) {
        emit(state.copyWith(
            errorMessage: failure.message, status: AboutUsStatus.updateError));
      }, (r) {
        emit(state.copyWith(status: AboutUsStatus.updated));
      });
    });
  }
}
