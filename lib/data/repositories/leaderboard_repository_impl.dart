import '../../domain/entities/leaderboard_user.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../datasources/leaderboard_remote_datasource.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {

  final LeaderboardRemoteDatasource remoteDatasource;

  LeaderboardRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<LeaderboardUser>> getLeaderboard() {

    return remoteDatasource.getLeaderboard();

  }

}