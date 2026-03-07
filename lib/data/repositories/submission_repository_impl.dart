import '../../domain/repositories/submission_repository.dart';
import '../datasources/submission_remote_datasource.dart';
import '../models/submission_model.dart';

class SubmissionRepositoryImpl implements SubmissionRepository {

  final SubmissionRemoteDatasource remoteDatasource;

  SubmissionRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> submitFlag(int challengeId, String flag) {

    final model = SubmissionModel(
      challengeId: challengeId,
      submittedFlag: flag,
    );

    return remoteDatasource.submitFlag(model);
  }
}