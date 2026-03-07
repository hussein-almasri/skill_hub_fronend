import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/leaderboard_user_model.dart';

class LeaderboardRemoteDatasource {

  final Dio dio;

  LeaderboardRemoteDatasource(this.dio);

  Future<List<LeaderboardUserModel>> getLeaderboard() async {

    final response = await dio.get(ApiConstants.leaderboard);

    final List data = response.data;

    return data.map((e) => LeaderboardUserModel.fromJson(e)).toList();

  }

}