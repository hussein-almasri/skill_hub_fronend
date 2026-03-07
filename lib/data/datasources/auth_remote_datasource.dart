import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/auth_model.dart';
import '../models/register_model.dart';

class AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasource(this.dio);

  Future<AuthModel> login(String email, String password) async {
    final response = await dio.post(
      ApiConstants.login,
      data: {
        "email": email,
        "password": password,
      },
    );

    return AuthModel.fromJson(response.data);
  }

  Future<void> register(RegisterModel model) async {
    await dio.post(
      ApiConstants.register,
      data: model.toJson(),
    );
  }
}