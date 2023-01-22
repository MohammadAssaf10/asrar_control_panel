import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/constants.dart';
import '../../../../../core/app/di.dart';
import '../../../domain/entities/file_entities.dart';
import '../../../domain/entities/xfile_entities.dart';
import '../../../domain/repositories/storage_file_repository.dart';

part 'gallery_event.dart';

part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final StorageFileRepository storageFileRepository =
      instance<StorageFileRepository>();

  GalleryBloc() : super(GalleryInitial()) {
    on<GetImageGallery>((event, emit) async {
      emit(GalleryLoadingState());
      final imageUrl = await storageFileRepository.getFile(
        FireBaseCollection.adImages,
      );
      imageUrl.fold((failure) {
        emit(GalleryErrorState(errorMessage: failure.message));
      }, (imageUrlList) {
        emit(GalleryLoadedState(list: imageUrlList));
      });
    });
    on<UploadImageToGallery>((event, emit) async {
      emit(UploadImageLoadingState());
      final uploadImage = await storageFileRepository.uploadFile(
          event.xFileEntities, event.folderName);
      uploadImage.fold(
        (failure) => emit(GalleryErrorState(errorMessage: failure.message)),
        (r) => emit(ImageUploadedSuccessfully()),
      );
    });
    on<DeleteImageFromGallery>((event, emit) async {
      emit(DeleteImageLoadingState());
      await storageFileRepository.deleteFile(
        event.folderName,
        event.fileName,
      );
      emit(ImageDeletedSuccessfully());
    });
  }
}
