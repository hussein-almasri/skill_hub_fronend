import '../entities/challenge.dart';

abstract class ChallengeRepository {
  Future<List<Challenge>> getChallenges();
  Future<Challenge> getChallengeById(int id);
}