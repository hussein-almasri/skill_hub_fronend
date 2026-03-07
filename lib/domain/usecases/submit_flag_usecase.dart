import '../repositories/submission_repository.dart';

class SubmitFlagUseCase {

  final SubmissionRepository repository;

  SubmitFlagUseCase(this.repository);

  Future<void> call(int challengeId, String flag) {

    return repository.submitFlag(challengeId, flag);

  }
}