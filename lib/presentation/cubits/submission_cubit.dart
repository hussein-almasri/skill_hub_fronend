import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/submit_flag_usecase.dart';

/// STATES
abstract class SubmissionState {}

class SubmissionInitial extends SubmissionState {}

class SubmissionLoading extends SubmissionState {}

class SubmissionSuccess extends SubmissionState {
  final int challengeId;

  SubmissionSuccess(this.challengeId);
}

class SubmissionError extends SubmissionState {
  final String message;

  SubmissionError(this.message);
}

/// CUBIT
class SubmissionCubit extends Cubit<SubmissionState> {

  final SubmitFlagUseCase submitFlagUseCase;

  SubmissionCubit(this.submitFlagUseCase) : super(SubmissionInitial());

  Future<void> submit(int challengeId, String flag) async {

    emit(SubmissionLoading());

    try {

      await submitFlagUseCase(challengeId, flag);

      emit(SubmissionSuccess(challengeId));

    } catch (e) {

      emit(SubmissionError("Wrong flag"));

    }

  }

}