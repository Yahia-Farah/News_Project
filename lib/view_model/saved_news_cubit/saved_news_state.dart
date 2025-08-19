part of 'saved_news_cubit.dart';

@immutable
sealed class SavedNewsState {}

final class SavedNewsInitial extends SavedNewsState {}
final class SuccessQueryState extends SavedNewsState {
  final List<Map<String, dynamic>> articles;
  SuccessQueryState({required this.articles});
}
final class FailureState extends SavedNewsState {
  final String errorMessage;
  FailureState({required this.errorMessage});
}
final class LoadingState extends SavedNewsState {}