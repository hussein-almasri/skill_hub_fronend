import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/create_challenge_model.dart';

class AdminRemoteDatasource {

  final Dio dio;

  AdminRemoteDatasource(this.dio);

  Future<void> createChallenge(CreateChallengeModel model) async {

    await dio.post(
      ApiConstants.challenges,
      data: model.toJson(),
    );

  }
  Future<void> deleteChallenge(int id) async {

  await dio.delete(
    "${ApiConstants.challenges}/$id",
  );

}



}