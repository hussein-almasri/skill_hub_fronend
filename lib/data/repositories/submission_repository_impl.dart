import '../datasources/submission_remote_datasource.dart';
import '../models/submission_model.dart';

class SubmissionRepositoryImpl {

  final SubmissionRemoteDatasource remote;

  SubmissionRepositoryImpl(this.remote);

  Future<void> submitFlag(int challengeId, String flag) {

    final model = SubmissionModel(
      challengeId: challengeId,
      submittedFlag: flag,
    );

    return remote.submitFlag(model);

  }

}