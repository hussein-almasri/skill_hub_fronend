import 'package:skill_hub_fronend/domain/entities/challenge.dart';
import 'package:skill_hub_fronend/domain/repositories/challenge_repository.dart';

class GetChallengeDetailsUseCase {
  final ChallengeRepository repository;

  GetChallengeDetailsUseCase(this.repository);

  Future<Challenge> call(int id) async {
    return await repository.getChallengeById(id);
  }
}