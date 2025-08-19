
import 'package:arab_contractors/models/branch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  BranchCubit() : super(BranchInitial());

  void getBranches({required String name}) async {
  emit(LoadingState());
  try {
    final response = await Dio().get('https://api.agify.io/?name=$name');
    final branch = Branch.fromJson(response.data);
    emit(SuccessfulState(branch: branch));
  } catch (error) {
    emit(FailureState(errorMessage: error.toString()));
  }

  }
}
