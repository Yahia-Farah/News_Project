import 'package:arab_contractors/models/articles_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '';
import '../../helper/database_helper.dart';
part 'saved_news_state.dart';

class SavedNewsCubit extends Cubit<SavedNewsState> {
  final db = DatabaseHelper.instance;

  SavedNewsCubit() : super(SavedNewsInitial());
  List<ArticlesResponseModel> articles = [];
  void getSavedNews() async {
    emit(LoadingState());
      final savedNews = await db.database;
     final  savedArticles=await savedNews.query('Saved_News');
      for(var article in savedArticles){
       articles.add(ArticlesResponseModel.fromJson(article));
      }
    emit(SuccessQueryState(articles: savedArticles));
  }
}
