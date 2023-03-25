part of 'about_us_bloc.dart';

abstract class AboutUsEvent extends Equatable {
  const AboutUsEvent();
}

class AddAbuotUsEvent extends AboutUsEvent {
  final String aboutUs;
  const AddAbuotUsEvent({required this.aboutUs});
  @override
  List<Object?> get props => [aboutUs];
}

class UpdateAbuotUsEvent extends AboutUsEvent {
  final String aboutUs;
  const UpdateAbuotUsEvent({required this.aboutUs});
  @override
  List<Object?> get props => [aboutUs];
}

class GetAbuotUsEvent extends AboutUsEvent {
  @override
  List<Object?> get props => [];
}
