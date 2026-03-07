import '../entities/challenge.dart';
import '../repositories/challenge_repository.dart';

class GetChallengesUseCase {

  final ChallengeRepository repository;

  GetChallengesUseCase(this.repository);

  Future<List<Challenge>> call() {
    return repository.getChallenges();
  }
}