import 'package:asrar_control_panel/features/home/domain/entities/file_entities.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/use_cases/get_file.dart';

part 'gallery_event.dart';

part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GetFileUseCase getFileUseCase;

  GalleryBloc({required this.getFileUseCase}) : super(GalleryInitial()) {
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
