import '../../data/repositories/submission_repository_impl.dart';

class SubmitFlagUseCase {

  final SubmissionRepositoryImpl repository;

  SubmitFlagUseCase(this.repository);

  Future<void> call(int challengeId, String flag) {

    return repository.submitFlag(challengeId, flag);

  }

}