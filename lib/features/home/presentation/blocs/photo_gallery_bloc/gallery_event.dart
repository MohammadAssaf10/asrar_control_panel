part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();
}

class GetImageGalleryEvent extends GalleryEvent {
  @override
  List<Object?> get props => [];
}

class UploadImageToGalleryEvent extends GalleryEvent {
  final XFileEntities xFileEntities;
  final String folderName;
  const UploadImageToGalleryEvent({
    required this.xFileEntities,
    required this.folderName,
  });
  @override
  List<Object?> get props => [xFileEntities, folderName];
}

class DeleteImageFromGalleryEvent extends GalleryEvent {
  final String folderName;
  final String fileName;
  const DeleteImageFromGalleryEvent({
    required this.fileName,
    required this.folderName,
  });
  @override
  List<Object?> get props => [fileName, folderName];
}
