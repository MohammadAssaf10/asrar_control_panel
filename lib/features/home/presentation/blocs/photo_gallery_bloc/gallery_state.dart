part of 'gallery_bloc.dart';

abstract class GalleryState extends Equatable {
  const GalleryState();
}

class GalleryInitial extends GalleryState {
  @override
  List<Object> get props => [];
}

class GalleryLoadedState extends GalleryState {
  final List<FileEntities> list;

  const GalleryLoadedState({required this.list});

  @override
  List<Object?> get props => [list];
}

class GalleryLoadingState extends GalleryState {
  @override
  List<Object?> get props => [];
}

class GalleryErrorState extends GalleryState {
  final String errorMessage;

  const GalleryErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
