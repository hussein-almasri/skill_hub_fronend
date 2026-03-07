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
}