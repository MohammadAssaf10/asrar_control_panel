part of 'terms_of_use_bloc.dart';

abstract class TermsOfUseEvent extends Equatable {
  const TermsOfUseEvent();
}

class AddTermsOfUseEvent extends TermsOfUseEvent {
  final String termsOfUse;
  const AddTermsOfUseEvent({required this.termsOfUse});
  @override
  List<Object?> get props => [termsOfUse];
}

class UpdateTermsOfUseEvent extends TermsOfUseEvent {
  final String termsOfUse;
  const UpdateTermsOfUseEvent({required this.termsOfUse});
  @override
  List<Object?> get props => [termsOfUse];
}

class GetTermsOfUseEvent extends TermsOfUseEvent {
  @override
  List<Object?> get props => [];
}
