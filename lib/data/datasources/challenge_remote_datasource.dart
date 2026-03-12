import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/challenge_model.dart';

class ChallengeRemoteDatasource {
  final Dio dio;

  ChallengeRemoteDatasource(this.dio);

  Future<List<ChallengeModel>> getChallenges() async {

    final response = await dio.get(ApiConstants.challenges);

    final List data = response.data;

    return data.map((e) => ChallengeModel.fromJson(e)).toList();
  }

  Future<ChallengeModel> getChallengeById(int id) async {

    final response = await dio.get(
      "${ApiConstants.challengeDetails}$id",
    );

    return ChallengeModel.fromJson(response.data);
  }

  Future<void> updateChallenge(
    int id,
    Map<String, dynamic> data,
  ) async {

    await dio.put(
      "${ApiConstants.challenges}/$id",
      data: data,
    );

  }
}