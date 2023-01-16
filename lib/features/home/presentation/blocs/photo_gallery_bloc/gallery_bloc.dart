import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/file_entities.dart';
import '../../../domain/repositories/storage_file_repository.dart';
import '../../../domain/use_cases/get_storage_file.dart';

part 'gallery_event.dart';

part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GetStorageFileUseCase getFileUseCase =
      GetStorageFileUseCase(storageFileRepository: instance<StorageFileRepository>());

  GalleryBloc() : super(GalleryInitial()) {
    on<GalleryEvent>((event, emit) async {
      if (event is GetImageGallery) {
        emit(GalleryLoadingState());
        final imageUrl = await getFileUseCase("adImages");
        imageUrl.fold((failure) {
          emit(GalleryErrorState(errorMessage: failure.message));
        }, (imageUrlList) {
          emit(GalleryLoadedState(list: imageUrlList));
        });
      }
    });
  }
}
