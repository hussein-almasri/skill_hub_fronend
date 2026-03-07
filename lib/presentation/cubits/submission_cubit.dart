import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/submit_flag_usecase.dart';

abstract class SubmissionState {}

class SubmissionInitial extends SubmissionState {}

class SubmissionLoading extends SubmissionState {}

class SubmissionSuccess extends SubmissionState {}

class SubmissionError extends SubmissionState {}

class SubmissionCubit extends Cubit<SubmissionState> {

  final SubmitFlagUseCase submitFlagUseCase;

  SubmissionCubit(this.submitFlagUseCase) : super(SubmissionInitial());

  Future<void> submitFlag(int challengeId, String flag) async {

    try {

      emit(SubmissionLoading());

      await submitFlagUseCase(challengeId, flag);

      emit(SubmissionSuccess());

    } catch (e) {

      emit(SubmissionError());

    }

  }

}