import 'package:arab_contractors/models/articles_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  List<ArticlesResponseModel> articles = [];
  void getNews() async {
    emit(LoadingState());
    //Database db = await DatabaseHelper.instance.database;
    await startHive();
    final newsBox = Hive.box('Saved_News_Hive');
    try {
      final response = await Dio().get(
        'https://newsapi.org/v2/everything?q=tesla&from=2025-07-20&sortBy=publishedAt&apiKey=0b0b2b834d2d44bdb18417936cc6136f',
      );
      //  db.delete('Saved_News');
      newsBox.deleteAll(articles);
      for (var article in response.data["articles"]) {
        final articleModel = ArticlesResponseModel.fromJson(article);
        articles.add(articleModel);
        //  db.insert('Saved_News', articleModel.toJson());
        newsBox.add(articleModel);
      }
      emit(SuccessState(articles: articles));
    } catch (error) {
      if (!Hive.isBoxOpen('Saved_News_Hive')) {
        emit(FailureState(errorMessage: error.toString()));
      } else {
        //  final savedNews = await db.query('Saved_News');
        //  for(var article in savedNews){
        //    articles.add(ArticlesResponseModel.fromJson(article));
        // }
        final savedNewsBox = Hive.box('Saved_News_Hive');
        for (var article in savedNewsBox.values) {
          articles.add(article);
        }

        emit(SuccessState(articles: articles));
      }
    }
  }


  void searchNews(String query) async {
    List<ArticlesResponseModel> filteredArticles = [];
    if (query.length >= 3) {
      try {
        for (var article in articles) {
          final title = article.title?.toLowerCase() ?? '';
          final description = article.description?.toLowerCase() ?? '';
          final content = article.content?.toLowerCase() ?? '';

          if (title.contains(query.toLowerCase()) ||
              description.contains(query.toLowerCase()) ||
              content.contains(query.toLowerCase())) {
            filteredArticles.add(article);
          }
        }

        emit(SuccessSearchState(filteredArticles: filteredArticles));
      } catch (error) {
        emit(FailureState(errorMessage: error.toString()));
      }
    } else {
      filteredArticles.removeRange(0, filteredArticles.length);
      emit(SuccessState(articles: articles));
    }
  }
}

Future<void> startHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArticlesResponseModelAdapter());
  Hive.registerAdapter(ArticlesSourceAdapter());
  await Hive.openBox('Saved_News_Hive');
}
