import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/entities/news_entities.dart';
import '../../domain/repositories/news_repository.dart';

class NewsRepositoryImpl extends NewsRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<int> getLastNewsId() async {
    int newsId = 0;
    final data = await db.collection(FireBaseCollection.news).get();
    if (data.size > 0) {
      for (var doc in data.docs) {
        if (doc["newsId"] > newsId) {
          newsId = doc["newsId"];
        }
      }
    }
    return newsId;
  }

  @override
  Future<Either<Failure, Unit>> addNews(
    NewsEntities news,
    String newsImageUrl,
  ) async {
    try {
      final int lastNewsId = await getLastNewsId();
      final Map<String, dynamic> newsEntities = NewsEntities(
        newsId: lastNewsId,
        newsTitle: news.newsTitle,
        newsContent: news.newsContent,
        newsImageName: news.newsImageName,
        newsImageUrl: newsImageUrl,
      ).toMap();
      await db
          .collection(FireBaseCollection.news)
          .doc(news.newsId.toString())
          .set(newsEntities);
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
