import 'package:equatable/equatable.dart';

class NewsEntities extends Equatable {
  final int newsId;
  final String newsTitle;
  final String newsContent;
  final String newsImageName;
  final String newsImageUrl;
  const NewsEntities({
    required this.newsId,
    required this.newsTitle,
    required this.newsContent,
    required this.newsImageName,
    required this.newsImageUrl,
  });
  @override
  List<Object> get props {
    return [
      newsId,
      newsTitle,
      newsContent,
      newsImageName,
      newsImageUrl,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'newsId': newsId,
      'newsTitle': newsTitle,
      'newsContent': newsContent,
      'newsimageName': newsImageName,
      'newsimageUrl': newsImageUrl,
    };
  }

  factory NewsEntities.fromMap(Map<String, dynamic> map) {
    return NewsEntities(
      newsId: map['newsId'],
      newsTitle: map['newsTitle'],
      newsContent: map['newsContent'],
      newsImageName: map['newsimageName'],
      newsImageUrl: map['newsimageUrl'],
    );
  }

  @override
  String toString() {
    return 'NewsEntities(newsId: $newsId, newsTitle: $newsTitle, newsContent: $newsContent, newsimageName: $newsImageName, newsimageUrl: $newsImageUrl)';
  }
}
