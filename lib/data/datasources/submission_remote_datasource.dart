import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/submission_model.dart';

class SubmissionRemoteDatasource {

  final Dio dio;

  SubmissionRemoteDatasource(this.dio);

  Future<void> submitFlag(SubmissionModel model) async {

    await dio.post(
      ApiConstants.submitFlag,
      data: model.toJson(),
    );

  }
}