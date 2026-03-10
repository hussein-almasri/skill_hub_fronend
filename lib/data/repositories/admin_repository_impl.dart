import '../datasources/admin_remote_datasource.dart';
import '../models/create_challenge_model.dart';

class AdminRepositoryImpl {

  final AdminRemoteDatasource remote;

  AdminRepositoryImpl(this.remote);

  Future<void> createChallenge(CreateChallengeModel model) {

    return remote.createChallenge(model);

  }
  Future<void> deleteChallenge(int id) {

  return remote.deleteChallenge(id);

} Future<void> updateChallenge(
    int id,
    Map<String, dynamic> data,
  ) {
    return remote.updateChallenge(
      id,
      data,
    );
  }

}