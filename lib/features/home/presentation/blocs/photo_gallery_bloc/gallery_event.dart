part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();
}

class GetImageGallery extends GalleryEvent {
  @override
  List<Object?> get props => [];
}

class UploadImageToGallery extends GalleryEvent {
  final XFileEntities xFileEntities;
  final String folderName;
  const UploadImageToGallery({
    required this.xFileEntities,
    required this.folderName,
  });
  @override
  List<Object?> get props => [xFileEntities, folderName];
}

class DeleteImageFromGallery extends GalleryEvent {
  final String folderName;
  final String fileName;
  const DeleteImageFromGallery({
    required this.fileName,
    required this.folderName,
  });
  @override
  List<Object?> get props => [fileName, folderName];
}
