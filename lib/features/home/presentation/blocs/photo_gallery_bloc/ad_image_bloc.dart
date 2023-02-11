import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/constants.dart';
import '../../../../../core/app/di.dart';
import '../../../domain/entities/ad_image_entities.dart';
import '../../../domain/entities/xfile_entities.dart';
import '../../../domain/repositories/ad_image_repository.dart';
import '../../../domain/repositories/storage_file_repository.dart';

part 'ad_image_event.dart';

part 'ad_image_state.dart';

class AdImageBloc extends Bloc<AdImageEvent, AdImageState> {
  final StorageFileRepository storageFileRepository =
      instance<StorageFileRepository>();
  final AdImageRepository adImageRepository = instance<AdImageRepository>();

  AdImageBloc() : super(AdImageInitial()) {
    on<GetAdImagesEvent>((event, emit) async {
      emit(AdImageLoadingState());
      (await adImageRepository.getAdImages()).fold((failure) {
        emit(AdImageErrorState(errorMessage: failure.message));
      }, (adImagesList) {
        emit(AdImagesLoadedState(adImagesList: adImagesList));
      });
    });
    on<AddAdImageEvent>((event, emit) async {
      emit(AddAdImageLoadingState());
      await (await (storageFileRepository.uploadFile(
        event.xFileEntities,
        FireBaseCollection.adImages,
      )))
          .fold((failure) {
        emit(AdImageErrorState(errorMessage: failure.message));
      }, (image) async {
        (await adImageRepository.addAdImage(event.adImage, image.url)).fold(
            (failure) {
          emit(AdImageErrorState(errorMessage: failure.message));
        }, (r) {
          emit(AdImageAddedSuccessfullyState());
        });
      });
    });
    on<DeleteAdImageEvent>((event, emit) async {
      emit(DeleteAdImageLoadingState());
      (await adImageRepository.deleteAdImage(event.adImage)).fold((failure) {
        emit(DeleteAdImageErrorState(errorMessage: failure.message));
      }, (r) {
        emit(ImageDeletedSuccessfullyState());
      });
    });
  }
}
