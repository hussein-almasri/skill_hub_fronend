import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'auth_interceptor.dart';
import '../storage/secure_storage.dart';

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    dio.interceptors.add(AuthInterceptor(SecureStorage()));

    // هذا مهم حتى نرى الأخطاء
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }
}