import '../../data/models/create_challenge_model.dart';
import '../../data/repositories/admin_repository_impl.dart';

class CreateChallengeUseCase {

  final AdminRepositoryImpl repository;

  CreateChallengeUseCase(this.repository);

  Future<void> call(CreateChallengeModel model) {

    return repository.createChallenge(model);

  }

}