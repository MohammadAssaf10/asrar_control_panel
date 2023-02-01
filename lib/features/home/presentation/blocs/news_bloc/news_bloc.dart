import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/constants.dart';
import '../../../../../core/app/di.dart';
import '../../../domain/entities/news_entities.dart';
import '../../../domain/entities/xfile_entities.dart';
import '../../../domain/repositories/news_repository.dart';
import '../../../domain/repositories/storage_file_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository = instance<NewsRepository>();
  final StorageFileRepository storageFileRepository =
      instance<StorageFileRepository>();

  NewsBloc() : super(NewsInitial()) {
    on<AddNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      await (await storageFileRepository.uploadFile(
              event.xFileEntities, FireBaseCollection.news))
          .fold((failure) {
        emit(NewsErrorState(errorMessage: failure.message));
      }, (image) async {
        (await newsRepository.addNews(event.news, image.url)).fold((failure) {
          emit(NewsErrorState(errorMessage: failure.message));
        }, (r) {
          emit(NewsAddedSuccessfullyState());
        });
      });
    });
  }
}
