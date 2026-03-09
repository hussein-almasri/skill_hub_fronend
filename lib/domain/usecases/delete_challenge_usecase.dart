import '../../data/repositories/admin_repository_impl.dart';

class DeleteChallengeUseCase {

  final AdminRepositoryImpl repository;

  DeleteChallengeUseCase(this.repository);

  Future<void> call(int id) {

    return repository.deleteChallenge(id);

  }

}