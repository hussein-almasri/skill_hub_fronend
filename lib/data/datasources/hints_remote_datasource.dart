import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/hint_model.dart';

class HintsRemoteDatasource {

  final Dio dio;

  HintsRemoteDatasource(this.dio);

  Future<List<HintModel>> getHints(int challengeId) async {

    final response = await dio.get(
      "${ApiConstants.hints}/$challengeId",
    );

    final List data = response.data;

    return data.map((e) => HintModel.fromJson(e)).toList();
  }

}