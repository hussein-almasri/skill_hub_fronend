import '../../domain/entities/user.dart';

class UserModel extends User {

  UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {

    return UserModel(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      role: json["role"],
    );

  }

}