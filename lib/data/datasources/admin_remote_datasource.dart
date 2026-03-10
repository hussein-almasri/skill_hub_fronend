import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/create_challenge_model.dart';

class AdminRemoteDatasource {

  final Dio dio;

  AdminRemoteDatasource(this.dio);

  Future<void> createChallenge(CreateChallengeModel model) async {

    try {

      await dio.post(
        "${ApiConstants.challenges}/",
        data: model.toJson(),
      );

    } on DioException catch (e) {

      throw Exception(e.response?.data ?? "Failed to create challenge");

    }

  }

  Future<void> deleteChallenge(int id) async {

    try {

      await dio.delete(
        "${ApiConstants.challenges}/$id",
      );

    } on DioException catch (e) {

      throw Exception(e.response?.data ?? "Failed to delete challenge");

    }

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