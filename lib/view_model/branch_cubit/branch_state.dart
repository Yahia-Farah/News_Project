
part of 'branch_cubit.dart';
@immutable
sealed class BranchState {}

final class BranchInitial extends BranchState {}
final class LoadingState extends BranchState {}
final class SuccessfulState extends BranchState {
  final Branch branch;

  SuccessfulState({required this.branch});
}
final class FailureState extends BranchState {
  final String errorMessage;

  FailureState({required this.errorMessage});
}
