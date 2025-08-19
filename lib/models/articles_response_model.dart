import 'package:hive/hive.dart';

part 'articles_response_model.g.dart';
@HiveType(typeId: 0)
class ArticlesResponseModel extends HiveObject {
  @HiveField(0)
  ArticlesSource? source;
  @HiveField(1)
  String? author;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? url;
  @HiveField(5)
  String? urlToImage;
  @HiveField(6)
  DateTime? publishedAt;
  @HiveField(7)
  String? content;
  ArticlesResponseModel({
    required this.source,
    required this.author,
    required this.content,
    required this.description,
    required this.publishedAt,
    required this.title,
    required this.url,
    required this.urlToImage,
  });
  factory ArticlesResponseModel.fromJson(Map<String, dynamic> source) =>
      ArticlesResponseModel(
        source: source["source"] != null
            ? ArticlesSource.fromJson(source["source"])
            : null,
        author: source['author'],
        content: source['content'],
        description: source['description'],
        publishedAt: DateTime.parse(source['publishedAt']),

        title: source['title'],
        url: source['url'],
        urlToImage: source['urlToImage'],
      );
  toJson() => {
    'author': author,
    'content': content,
    'description': description,
    'publishedAt': publishedAt.toString(),
    'title': title,
    'url': url,
    'urlToImage': urlToImage,
  };
}
@HiveType(typeId: 1)
class ArticlesSource extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  ArticlesSource({required this.name, required this.id});
  factory ArticlesSource.fromJson(Map<String, dynamic> source) =>
      ArticlesSource(name: source['name'], id: source['id']);
  toJson() => {'name': name, 'id': id};
}
