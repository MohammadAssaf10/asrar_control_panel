part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class AddNewsEvent extends NewsEvent {
  final NewsEntities news;
  final XFileEntities xFileEntities;
  const AddNewsEvent({
    required this.news,
    required this.xFileEntities,
  });
  @override
  List<Object?> get props => [news, xFileEntities];
}

class GetNewsListEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}

class DeleteNewsEvent extends NewsEvent {
  final NewsEntities news;
  const DeleteNewsEvent({required this.news});

  @override
  List<Object?> get props => [news];
}
