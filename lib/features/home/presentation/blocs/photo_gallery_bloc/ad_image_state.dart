part of 'ad_image_bloc.dart';

abstract class AdImageState extends Equatable {
  const AdImageState();
}

class AdImageInitial extends AdImageState {
  @override
  List<Object> get props => [];
}

class AdImagesLoadedState extends AdImageState {
  final List<AdImageEntities> adImagesList;

  const AdImagesLoadedState({required this.adImagesList});

  @override
  List<Object?> get props => [adImagesList];
}

class AdImageLoadingState extends AdImageState {
  @override
  List<Object?> get props => [];
}

class AddAdImageLoadingState extends AdImageState {
  @override
  List<Object?> get props => [];
}

class DeleteAdImageLoadingState extends AdImageState {
  @override
  List<Object?> get props => [];
}
class DeleteAdImageErrorState extends AdImageState {
  final String errorMessage;

  const DeleteAdImageErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class AdImageErrorState extends AdImageState {
  final String errorMessage;

  const AdImageErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class AdImageAddedSuccessfullyState extends AdImageState {
  @override
  List<Object?> get props => [];
}

class ImageDeletedSuccessfullyState extends AdImageState {
  @override
  List<Object?> get props => [];
}
