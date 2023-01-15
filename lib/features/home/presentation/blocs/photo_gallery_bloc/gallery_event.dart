part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();
}
class GetImageGallery extends GalleryEvent{
  @override
  List<Object?> get props => [];
}
