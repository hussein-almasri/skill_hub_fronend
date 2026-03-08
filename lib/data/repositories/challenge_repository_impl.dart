import '../../domain/entities/challenge.dart';
import '../../domain/repositories/challenge_repository.dart';
import '../datasources/challenge_remote_datasource.dart';

class ChallengeRepositoryImpl implements ChallengeRepository {

  final ChallengeRemoteDatasource remoteDatasource;

  ChallengeRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Challenge>> getChallenges() {
    return remoteDatasource.getChallenges();
  }
  @override
Future<Challenge> getChallengeById(int id) async {
  return await remoteDatasource.getChallengeById(id);
}
  
}