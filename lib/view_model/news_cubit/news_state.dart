part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}
final class SuccessState extends NewsState {
  final List<ArticlesResponseModel> articles;

  SuccessState({required this.articles});

}
final class FailureState extends NewsState {
  final String errorMessage;
  FailureState({required this.errorMessage});
}
final class LoadingState extends NewsState {}
final class SuccessSearchState extends NewsState{
  final List<ArticlesResponseModel> filteredArticles;
  SuccessSearchState({required this.filteredArticles});
}


