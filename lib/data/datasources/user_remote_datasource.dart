import 'package:dio/dio.dart';
import 'package:skill_hub_fronend/data/models/user_stats_model.dart';
import '../../core/constants/api_constants.dart';
import '../models/user_model.dart';

class UserRemoteDatasource {

  final Dio dio;

  UserRemoteDatasource(this.dio);

  Future<UserModel> getMe() async {

    final response = await dio.get(ApiConstants.getMe);

    return UserModel.fromJson(response.data);

  }
  Future<UserStatsModel> getStats() async {

  final response = await dio.get("/users/stats");

  return UserStatsModel.fromJson(response.data);

}

}