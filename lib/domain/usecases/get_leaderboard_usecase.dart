import '../entities/leaderboard_user.dart';
import '../repositories/leaderboard_repository.dart';

class GetLeaderboardUseCase {

  final LeaderboardRepository repository;

  GetLeaderboardUseCase(this.repository);

  Future<List<LeaderboardUser>> call() {

    return repository.getLeaderboard();

  }

}