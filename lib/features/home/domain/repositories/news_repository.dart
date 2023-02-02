import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/news_entities.dart';

abstract class NewsRepository {
  Future<Either<Failure, Unit>> addNews(
    NewsEntities news,
    String newsImageUrl,
  );
  Future<Either<Failure, List<NewsEntities>>> getNewsList();
  Future<Either<Failure, Unit>> deleteNews(
    NewsEntities news,
  );
}
