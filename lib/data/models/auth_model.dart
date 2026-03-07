import '../../domain/entities/auth.dart';

class AuthModel extends Auth {
  AuthModel({
    required super.accessToken,
    required super.tokenType,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
    );
  }
}