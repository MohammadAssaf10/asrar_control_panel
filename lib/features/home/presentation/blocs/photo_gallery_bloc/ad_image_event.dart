part of 'ad_image_bloc.dart';

abstract class AdImageEvent extends Equatable {
  const AdImageEvent();
}

class GetAdImagesEvent extends AdImageEvent {
  @override
  List<Object?> get props => [];
}

class AddAdImageEvent extends AdImageEvent {
  final AdImageEntities adImage;
  final XFileEntities xFileEntities;
  const AddAdImageEvent({
    required this.adImage,
    required this.xFileEntities,
  });
  @override
  List<Object?> get props => [adImage, xFileEntities];
}

class DeleteAdImageEvent extends AdImageEvent {
  final AdImageEntities adImage;

  const DeleteAdImageEvent({
    required this.adImage,
  });
  @override
  List<Object?> get props => [adImage];
}
